```
title: Getting Started (Windows)
layout: architecture
tags: ['architecture']
```

General Instructions
--------------------

The most up to date instructions are available in the [README.md][readme]
file. This page contains additional procedures for custom environments.

Install Acquia Dev Desktop
--------------------------

If this is your first Drupal 7 install, you may want to install the
Acquia Dev Destop on your machine since it will provide you with a
complete environment at the click of a button. It will set up Apache,
MySQL, PHP and install an instance of Drupal. Once the environment is
set up you can easily install Drupal WxT using the same *AMP resources.

1.  Download and install [Acquia Dev Desktop][acquiadesktop]
2.  With the following settings during the interactive installer:

  ```bash
  Dev Desktop stack location: C:\Program Files\acquia-drupal
  Site location: C:\<LocalFolder>\Desktop\Sites\acquia-drupal
  ```

Configure Environment variables, host file and Apache
-----------------------------------------------------

1.  Update your $PATH Environment Variable to add the following location:

  ```bash
  C:\Program Files\acquia-drupal\mysql\bin;
  ```

2.  Add a new entry in your hosts file (C:\Windows\System32\drivers\etc\hosts):

  ```bash
  127.0.0.1    drupalwxt
  ```

3.  Update your virtual host file from C:/Program Files/acquia-drupal/apache/conf/vhosts.conf with the following:

  ```bash
  <VirtualHost *>
    ServerName drupalwxt
    DocumentRoot "C:\LocalFolder\Desktop\Sites\drupalwxt"
    <Directory "C:\LocalFolder\Desktop\Sites\drupalwxt">
      Options Indexes FollowSymLinks ExecCGI
      AllowOverride All
     Order allow,deny
      Allow from all
    </Directory>
  </VirtualHost>
  ```

Download and install Drush
--------------------------

Note: Drush makes calls to executables without specifying the full path to their locations. In order to resolve the correct location, their full path should be included in %PATH% environment variable. The easiest way to do this is by selecting the feature Register Environment Variables when running the installation package. The location can also be added manually to your %PATH% user environment variable.

* Download Drush 5.8 or higher from Drush download page.
* Install Drush by following the installation guide.
* Alternatively, the latest Drush installation instructions on Drupal.org for Windows can also be used.
* In case you still don't know how important it is to register environment variables See:Install Drush to work with Git Bash Window: https://drupal.org/node/1843176
* You should be able to run Drush from within the Git Bash Window!

Download and install Git
------------------------

* Download Git 1.7.10 or higher from [MsysGit][msysgit].
* Install Git 1.7.10 or higher (Some lower versions of git do not apply patches from the make file with Drush Make).

Configure your proxy (if applicable)
------------------------------------

* For Drush: Create and/or Edit the file _curlrc with the following content and paste the following into your home directory of your local environment:

  ```bash
  --proxy <domain>:<port>
  --proxy-user <username>:<password>
  ```

* For Git: Open Git Bash command prompt and run the following command:

  ```bash
  git config --global http.proxy http://<username>:<password>@<domain>:<port>
  git config --global http.sslverify false
  ```

* For Drupal: To facilitate Drupal’s automatic update and App functionality you must enable HTTP proxy support in Drupal itself, after building and installing Drupal, modify the following lines in your settings.php file. This isn't mandatory to test the distribution.

  ```bash
  $conf['proxy_server'] = 'www.proxyserver.ca';
  $conf['proxy_port'] = 80;
  $conf['proxy_username'] = '';
  $conf['proxy_password'] = '';
  $conf['proxy_exceptions'] = array('127.0.0.1', 'localhost');
  ```

Configure your php.ini file
---------------------------

* Locate your php.ini file. The acquia install included a phpinfo.php file. http://localhost:8082/phpinfo.php

  ```bash
  C:/Program Files/acquia-drupal/php5_3
  ```

* Ensure the following line has the appropriate memory_limit set

  ```bash
  memory_limit = 192M
  ```

* Windows users: Ensure the windows permission settings allow for the PEAR distribution to be installed with the Acquia PHP install and php.ini is pointing to pear.

  ```bash
  include_path = ".;C:\Program Files\acquia-drupal\common\pear"
  ```

* or download and run

  ```bash
  C:\Program Files (x86)\acquia-drupal\php5_3\pear\go-pear.phar
  ```

* See [Getting Pear Working on Windows 7][blog_stuart]


<!-- Links Referenced -->


[acquiadesktop]:    http://www.acquia.com/products-services/dev-desktop
[blog_stuart]:      http://blog.stuartherbert.com/php/2012/05/10/getting-pear-working-on-windows-7
[msysgit]:                 http://msysgit.github.com
[readme]:           https://github.com/wet-boew/wet-boew-drupal/blob/7.x-1.x/README.md
