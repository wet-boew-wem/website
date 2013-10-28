# The DocPad Configuration File

# Require
fsUtil = require('fs')
marked = require 'docpad-plugin-marked/node_modules/marked'
pathUtil = require('path')

# It is simply a CoffeeScript Object which is parsed by CSON
docpadConfig = {

	# =================================
	# Template Data
	# These are variables that will be accessible via our templates
	# To access one of these within our templates, refer to the FAQ: https://github.com/bevry/docpad/wiki/FAQ

	templateData:

		# Specify some site properties
		site:
			# The production url of our website
			url: "http://docs.drupalwxt.org"

			# Here are some old site urls that you would like to redirect from
			oldUrls: []

			# The default title of our website
			title: "Drupal WxT Documentation"

			# The website description (for SEO)
			description: """
				The Web Experience Toolkit Drupal Variant documentation website.
				"""

			# The website keywords (for SEO) separated by commas
			keywords: """
				documentation, drupal, wxt, enterprise, devops
				"""

			# The website author's name
			author: "William Hearn"

			# The website author's email
			email: "william.hearn@statcan.gc.ca"

			# Styles
			styles: [
				"/styles/twitter-bootstrap.css"
				"/styles/style.css"
				"/styles/monokai.css"
			]

			# Scripts
			scripts: [
				"//cdnjs.cloudflare.com/ajax/libs/jquery/1.10.2/jquery.min.js"
				"//cdnjs.cloudflare.com/ajax/libs/modernizr/2.6.2/modernizr.min.js"
				"/vendor/twitter-bootstrap/dist/js/bootstrap.min.js"
				"/scripts/script.js"
			]

			services:
				disqus: "drupalwxt"

		# -----------------------------
		# Helper Functions

		# Get the prepared site/document title
		# Often we would like to specify particular formatting to our page's title
		# we can apply that formatting here
		getPreparedTitle: ->
			# if we have a document title, then we should use that and suffix the site's title onto it
			if @document.title
				"#{@document.title} | #{@site.title}"
			# if our document does not have it's own title, then we should just use the site's title
			else
				@site.title

		# Get the prepared site/document description
		getPreparedDescription: ->
			# if we have a document description, then we should use that, otherwise use the site's description
			@document.description or @site.description

		# Get the prepared site/document keywords
		getPreparedKeywords: ->
			# Merge the document keywords with the site keywords
			@site.keywords.concat(@document.keywords or []).join(', ')

		# Read File
		readFile: (relativePath) ->
			path = @document.fullDirPath+'/'+relativePath
			result = fsUtil.readFileSync(path)
			if result instanceof Error
				throw result
			else
				return result.toString()

		# Code File
		codeFile: (relativePath,language) ->
			language ?= pathUtil.extname(relativePath).substr(1)
			contents = @readFile(relativePath)
			return """<pre><code class="#{language}">#{contents}</code></pre>"""

    # MarkDown File
		markdownFile: (relativePath,language) ->
			language ?= pathUtil.extname(relativePath).substr(1)
			contents = @readFile(relativePath)
			marked.setOptions({
				breaks: false
				gfm: true
				pedantic: false
				sanitize: false
				tables: true
				highlight: null
			})
			return marked(contents)

	# =================================
	# Collections
	# These are special collections that our website makes available to us

	collections:
		architecture: (database) ->
			database.findAllLive({tags:$has:'architecture'}, [date:-1])

		concepts: (database) ->
			database.findAllLive({tags:$has:'concept'}, [date:-1])

		features: (database) ->
			database.findAllLive({tags:$has:'feature'}, [date:-1])

		modules: (database) ->
			database.findAllLive({tags:$has:'module'}, [name:1])

		pages: (database) ->
			database.findAllLive({pageOrder: $exists: true}, [pageOrder:1,title:1])

		performance: (database) ->
			database.findAllLive({tags:$has:'performance'}, [date:-1])

		posts: (database) ->
			database.findAllLive({tags:$has:'post'}, [date:-1])

		profiles: (database) ->
			database.findAllLive({tags:$has:'profile'}, [name:1])

		themes: (database) ->
			database.findAllLive({tags:$has:'theme'}, [name:1])

	# =================================
	# Plugins

	plugins:
		downloader:
			downloads: [
				{
					name: 'Twitter Bootstrap'
					path: 'src/files/vendor/twitter-bootstrap'
					url: 'https://codeload.github.com/twbs/bootstrap/tar.gz/master'
					tarExtractClean: true
				}
			]

		highlightjs:
			aliases:
				vcl: 'perl'

		downloader:
    	downloads: [
    		{
          name: 'WetKit Readme'
          path: 'src/documents/wxt/tmp/wetkit.html.md'
          url: 'https://raw.github.com/wet-boew/wet-boew-drupal/7.x-1.x/README.md'
        }
      	{
          name: 'WetKit Admin Readme'
          path: 'src/documents/wxt/tmp/wetkit-admin.html.md'
          url: 'https://raw.github.com/wet-boew-wem/wetkit-admin/7.x-1.x/README.md'
        }
        {
          name: 'WetKit Bean Readme'
          path: 'src/documents/wxt/tmp/wetkit-bean.html.md'
          url: 'https://raw.github.com/wet-boew-wem/wetkit-bean/7.x-1.x/README.md'
        }
        {
          name: 'WetKit Breadcrumbs Readme'
          path: 'src/documents/wxt/tmp/wetkit-breadcrumbs.html.md'
          url: 'https://raw.github.com/wet-boew-wem/wetkit-breadcrumbs/7.x-1.x/README.md'
        }
      	{
          name: 'WetKit Core Readme'
          path: 'src/documents/wxt/tmp/wetkit-core.html.md'
          url: 'https://raw.github.com/wet-boew-wem/wetkit-core/7.x-1.x/README.md'
        }
        {
          name: 'WetKit Demo Readme'
          path: 'src/documents/wxt/tmp/wetkit-demo.html.md'
          url: 'https://raw.github.com/wet-boew-wem/wetkit-demo/7.x-1.x/README.md'
        }
        {
          name: 'WetKit Deployment Readme'
          path: 'src/documents/wxt/tmp/wetkit-deployment.html.md'
          url: 'https://raw.github.com/wet-boew-wem/wetkit-deployment/7.x-1.x/README.md'
        }
        {
          name: 'WetKit Images Readme'
          path: 'src/documents/wxt/tmp/wetkit-images.html.md'
          url: 'https://raw.github.com/wet-boew-wem/wetkit-images/7.x-1.x/README.md'
        }
        {
          name: 'WetKit Language Readme'
          path: 'src/documents/wxt/tmp/wetkit-language.html.md'
          url: 'https://raw.github.com/wet-boew-wem/wetkit-language/7.x-1.x/README.md'
        }
        {
          name: 'WetKit Layout Readme'
          path: 'src/documents/wxt/tmp/wetkit-layouts.html.md'
          url: 'https://raw.github.com/wet-boew-wem/wetkit-layouts/7.x-1.x/README.md'
        }
        {
          name: 'WetKit Menu Readme'
          path: 'src/documents/wxt/tmp/wetkit-menu.html.md'
          url: 'https://raw.github.com/wet-boew-wem/wetkit-menu/7.x-1.x/README.md'
        }
        {
          name: 'WetKit Metatag Readme'
          path: 'src/documents/wxt/tmp/wetkit-metatag.html.md'
          url: 'https://raw.github.com/wet-boew-wem/wetkit-metatag/7.x-1.x/README.md'
        }
        {
          name: 'WetKit Migrate Readme'
          path: 'src/documents/wxt/tmp/wetkit-migrate.html.md'
          url: 'https://raw.github.com/wet-boew-wem/wetkit-migrate/7.x-1.x/README.md'
        }
        {
          name: 'WetKit Pages Readme'
          path: 'src/documents/wxt/tmp/wetkit-pages.html.md'
          url: 'https://raw.github.com/wet-boew-wem/wetkit-pages/7.x-1.x/README.md'
        }
        {
          name: 'WetKit Search Readme'
          path: 'src/documents/wxt/tmp/wetkit-search.html.md'
          url: 'https://raw.github.com/wet-boew-wem/wetkit-search/7.x-1.x/README.md'
        }
        {
          name: 'WetKit Theme Readme'
          path: 'src/documents/wxt/tmp/wetkit-theme.html.md'
          url: 'https://raw.github.com/wet-boew-wem/wetkit-theme/7.x-1.x/README.md'
        }
        {
          name: 'WetKit Users Readme'
          path: 'src/documents/wxt/tmp/wetkit-users.html.md'
          url: 'https://raw.github.com/wet-boew-wem/wetkit-users/7.x-1.x/README.md'
        }
        {
          name: 'WetKit WETBOEW Readme'
          path: 'src/documents/wxt/tmp/wetkit-wetboew.html.md'
          url: 'https://raw.github.com/wet-boew-wem/wetkit-wetboew/7.x-1.x/README.md'
        }
        {
          name: 'WetKit Widgets Readme'
          path: 'src/documents/wxt/tmp/wetkit-widgets.html.md'
          url: 'https://raw.github.com/wet-boew-wem/wetkit-widgets/7.x-1.x/README.md'
        }
        {
          name: 'WetKit WYSIWYG Readme'
          path: 'src/documents/wxt/tmp/wetkit-wysiwyg.html.md'
          url: 'https://raw.github.com/wet-boew-wem/wetkit-wysiwyg/7.x-1.x/README.md'
        }
        {
          name: 'WetKit Ember Readme'
          path: 'src/documents/wxt/tmp/wetkit-ember.html.md'
          url: 'https://raw.github.com/wet-boew-wem/wetkit-ember/7.x-1.x/README.md'
        }
        {
          name: 'WetKit Omega Readme'
          path: 'src/documents/wxt/tmp/wetkit-omega.html.md'
          url: 'https://raw.github.com/wet-boew-wem/wetkit-omega/7.x-1.x/README.md'
        }
        {
          name: 'WetKit Shiny Readme'
          path: 'src/documents/wxt/tmp/wetkit-shiny.html.md'
          url: 'https://raw.github.com/wet-boew-wem/wetkit-shiny/7.x-1.x/README.md'
        }
      ]

	# =================================
	# DocPad Events

	# Here we can define handlers for events that DocPad fires
	# You can find a full listing of events on the DocPad Wiki
	events:

		# Server Extend
		# Used to add our own custom routes to the server before the docpad routes are added
		serverExtend: (opts) ->
			# Extract the server from the options
			{server} = opts
			docpad = @docpad

			# As we are now running in an event,
			# ensure we are using the latest copy of the docpad configuraiton
			# and fetch our urls from it
			latestConfig = docpad.getConfig()
			oldUrls = latestConfig.templateData.site.oldUrls or []
			newUrl = latestConfig.templateData.site.url

			# Redirect any requests accessing one of our sites oldUrls to the new site url
			server.use (req,res,next) ->
				if req.headers.host in oldUrls
					res.redirect(newUrl+req.url, 301)
				else
					next()
}


# Export our DocPad Configuration
module.exports = docpadConfig
