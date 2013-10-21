```
title: Varnish
layout: performance
tags: ['varnish','performance']
```

![Varnish Banner][varnish_banner]

[Varnish][varnish] is an open source software-only reverse HTTP caching proxy (often referred to as a Web Accelerator). Varnish is developed on Linux but can be compiled on other UNIX operating systems. It is heavily multi-threaded and is capable of taking advantage of the memory available on 64-bit systems as well as 32-bit systems, and should scale as CPU’s are added. Reputedly, Varnish can respond to hundreds of requests per second.

A caching reverse proxy is a layer of software that sits between the external world and the web server. Very often with websites, the same static page is served over and over. Varnish caches these web pages and when an HTTP request comes in for a static page, Varnish will retrieve the cached page from virtual memory itself and quickly return it to the web client from memory. In this way, the overhead of the Apache web server and WCMS application are avoided altogether.

Varnish is very configurable, so the caching strategy can be individually tailored for every installation. Furthermore, Varnish provides a mechanism that allows it to be integrated with Drupal. By allowing Drupal itself to indicate when a cache entry should be invalidated and refreshed, pages can be safely cached for longer periods of time and therefore increase the number of times that Varnish can respond with a cached web page without passing the request back to Apache and Drupal.

Naturally, Varnish does not need to reside on the same server as Apache and can be placed in front as a separate access point for enhanced performance.

## Load Balancing (Optional)

Varnish is also a software load balancer. Varnish uses round-robin balancing to an arbitrary number of back-ends. Different guidelines can be provided to each backend in case they do not have identical capabilities. Other balancing policies are available too, including random assignment and assignment based on server health. Varnish can use backend health polling so that in the case where one server is becoming overwhelmed; traffic will not be directed to that server.

## Default VCL

Below is an example of a best practice default.vcl for varnish based on the [MyPlanetDigital][myplanetdigital] Ariadne github repository: [Default VCL][varnish_vcl]

``` bash
# This is a basic VCL configuration file for varnish.  See the vcl(7)
# man page for details on VCL syntax and semantics.
#

# TODO: Update internal subnet ACL and security.

# Define the internal network subnet.
# These are used below to allow internal access to certain files while not
# allowing access from the public internet.
# acl internal {
#  "192.10.0.0"/24;
# }

# Default backend definition.  Set this to point to your content
# server.
#
backend default {
  .host = "<%= node['varnish']['backend_host'] %>";
  .port = "<%= node['varnish']['backend_port'] %>";
  .connect_timeout = 600s;
  .first_byte_timeout = 600s;
  .between_bytes_timeout = 600s;
}

# Respond to incoming requests.
sub vcl_recv {
  # Use anonymous, cached pages if all backends are down.
  if (!req.backend.healthy) {
    unset req.http.Cookie;
  }

  # Allow the backend to serve up stale content if it is responding slowly.
  set req.grace = 6h;

  # Pipe these paths directly to Apache for streaming.
  #if (req.url ~ "^/admin/content/backup_migrate/export") {
  #  return (pipe);
  #}

  # Do not cache these paths.
  if (req.url ~ "^/status\.php$" ||
      req.url ~ "^/update\.php$" ||
      req.url ~ "^/admin$" ||
      req.url ~ "^/admin/.*$" ||
      req.url ~ "^/flag/.*$" ||
      req.url ~ "^.*/ajax/.*$" ||
      req.url ~ "^.*/ahah/.*$") {
       return (pass);
  }

  # Do not allow outside access to cron.php or install.php.
  #if (req.url ~ "^/(cron|install)\.php$" && !client.ip ~ internal) {
    # Have Varnish throw the error directly.
  #  error 404 "Page not found.";
    # Use a custom error page that you've defined in Drupal at the path "404".
    # set req.url = "/404";
  #}

  # Always cache the following file types for all users. This list of extensions
  # appears twice, once here and again in vcl_fetch so make sure you edit both
  # and keep them equal.
  if (req.url ~ "(?i)\.(pdf|asc|dat|txt|doc|xls|ppt|tgz|csv|png|gif|jpeg|jpg|ico|swf|css|js)(\?.*)?$") {
    unset req.http.Cookie;
  }

  # Remove all cookies that Drupal doesn't need to know about. We explicitly
  # list the ones that Drupal does need, the SESS and NO_CACHE. If, after
  # running this code we find that either of these two cookies remains, we
  # will pass as the page cannot be cached.
  if (req.http.Cookie) {
    # 1. Append a semi-colon to the front of the cookie string.
    # 2. Remove all spaces that appear after semi-colons.
    # 3. Match the cookies we want to keep, adding the space we removed
    #    previously back. (\1) is first matching group in the regsuball.
    # 4. Remove all other cookies, identifying them by the fact that they have
    #    no space after the preceding semi-colon.
    # 5. Remove all spaces and semi-colons from the beginning and end of the
    #    cookie string.
    set req.http.Cookie = ";" + req.http.Cookie;
    set req.http.Cookie = regsuball(req.http.Cookie, "; +", ";");
    set req.http.Cookie = regsuball(req.http.Cookie, ";(SESS[a-z0-9]+|SSESS[a-z0-9]+|NO_CACHE)=", "; \1=");
    set req.http.Cookie = regsuball(req.http.Cookie, ";[^ ][^;]*", "");
    set req.http.Cookie = regsuball(req.http.Cookie, "^[; ]+|[; ]+$", "");

    if (req.http.Cookie == "") {
      # If there are no remaining cookies, remove the cookie header. If there
      # aren't any cookie headers, Varnish's default behavior will be to cache
      # the page.
      unset req.http.Cookie;
    }
    else {
      # If there is any cookies left (a session or NO_CACHE cookie), do not
      # cache the page. Pass it on to Apache directly.
      return (pass);
    }
  }
}

# Set a header to track a cache HIT/MISS.
sub vcl_deliver {
  if (obj.hits > 0) {
    set resp.http.X-Varnish-Cache = "HIT";
  }
  else {
    set resp.http.X-Varnish-Cache = "MISS";
  }
}

# Code determining what to do when serving items from the Apache servers.
# beresp == Back-end response from the web server.
sub vcl_fetch {
  # We need this to cache 404s, 301s, 500s. Otherwise, depending on backend but
  # definitely in Drupal's case these responses are not cacheable by default.
  if (beresp.status == 404 || beresp.status == 301 || beresp.status == 500) {
    set beresp.ttl = 10m;
  }

  # Don't allow static files to set cookies.
  # (?i) denotes case insensitive in PCRE (perl compatible regular expressions).
  # This list of extensions appears twice, once here and again in vcl_recv so
  # make sure you edit both and keep them equal.
  if (req.url ~ "(?i)\.(pdf|asc|dat|txt|doc|xls|ppt|tgz|csv|png|gif|jpeg|jpg|ico|swf|css|js)(\?.*)?$") {
    unset beresp.http.set-cookie;
  }

  # Allow items to be stale if needed.
  set beresp.grace = 6h;
}

# In the event of an error, show friendlier messages.
sub vcl_error {
  # Redirect to some other URL in the case of a homepage failure.
  #if (req.url ~ "^/?$") {
  #  set obj.status = 302;
  #  set obj.http.Location = "http://backup.example.com/";
  #}

  # Otherwise redirect to the homepage, which will likely be in the cache.
  set obj.http.Content-Type = "text/html; charset=utf-8";
  synthetic {"
<html>
<head>
  <title>Page Unavailable</title>
  <style>
    body { background: #303030; text-align: center; color: white; }
    #page { border: 1px solid #CCC; width: 500px; margin: 100px auto 0; padding: 30px; background: #323232; }
    a, a:link, a:visited { color: #CCC; }
    .error { color: #222; }
  </style>
</head>
<body onload="setTimeout(function() { window.location = '/' }, 5000)">
  <div id="page">
    <h1 class="title">Page Unavailable</h1>
    <p>The page you requested is temporarily unavailable.</p>
    <p>We're redirecting you to the <a href="/">homepage</a> in 5 seconds.</p>
    <div class="error">(Error "} + obj.status + " " + obj.response + {")</div>
  </div>
</body>
</html>
"};
  return (deliver);
}

```

<!-- Links Referenced -->

[myplanetdigital]:  http://www.myplanetdigital.com
[varnish]:          https://www.varnish-cache.org
[varnish_banner]:   https://dl.dropboxusercontent.com/u/38413195/drupalwxt/performance/varnish-cache.png
[varnish_vcl]:      https://github.com/myplanetdigital/ariadne/blob/master/cookbooks-override/varnish/templates/default/default.vcl.erb
