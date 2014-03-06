###
# Blog settings
###

# Time.zone = "UTC"

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"

  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  # blog.sources = "{year}-{month}-{day}-{title}.html"
  # blog.taglink = "tags/{tag}.html"
  # blog.layout = "layout"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  # Enable pagination
  blog.paginate = true
  blog.per_page = 10
  blog.page_link = "page/{num}"
end

page "/feed.xml", layout: false

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", layout: false
#
# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"

  activate :favicon_maker, icons: {
    'favicon_template.png' => [
      { icon: 'apple-touch-icon-152x152-precomposed.png' },
      { icon: 'apple-touch-icon-144x144-precomposed.png' },
      { icon: 'apple-touch-icon-120x120-precomposed.png' },
      { icon: 'apple-touch-icon-114x114-precomposed.png' },
      { icon: 'apple-touch-icon-76x76-precomposed.png' },
      { icon: 'apple-touch-icon-72x72-precomposed.png' },
      { icon: 'apple-touch-icon-60x60-precomposed.png' },
      { icon: 'apple-touch-icon-57x57-precomposed.png' },
      { icon: 'apple-touch-icon-precomposed.png', size: '57x57' },
      { icon: 'apple-touch-icon.png', size: '57x57' },
      { icon: 'favicon-196x196.png' },
      { icon: 'favicon-160x160.png' },
      { icon: 'favicon-96x96.png' },
      { icon: 'favicon-32x32.png' },
      { icon: 'favicon-16x16.png' },
      { icon: 'favicon.png', size: '16x16' },
      { icon: 'favicon.ico', size: '64x64,32x32,24x24,16x16' },
      { icon: 'mstile-144x144', format: 'png' }
    ]
  }

  # Pull in the the Tapir jQuery plugin on build until there's a Middleman
  # plugin to do it
  require 'net/http'
  Net::HTTP.start('https://raw.github.com') do |http|
    file = open(File.expand_path('../source/javascripts/jquery-tapir.min.js',
                                 __FILE__), 'wb')
    uri = URI.encode('/TapirGo/jquery-plugin/master/jquery-tapir.min.js')
    begin
      http.request_get(uri) do |response|
        response.read_body do |segment|
          file.write(segment)
        end
      end
    ensure
      file.close
    end
  end

  if File.exist?(File.expand_path('../.secrets.yml', __FILE__))
    activate :tapirgo do |tapir|
      require 'yaml'
      yaml = YAML.load_file(File.expand_path('../.secrets.yml', __FILE__))
      tapir.api_key = yaml['tapirgo']['secret']
    end
  end
end

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.method = :git
end

@nav_external_links = {
  GitHub: {
    icon: 'fa fa-github-square fa-2x',
    url: 'https://github.com/RoboticCheese'
  },
  Twitter: {
    icon: 'fa fa-twitter-square fa-2x',
    url: 'https://twitter.com/RoboticCheese'
  },
  LinkedIn: {
    icon: 'fa fa-linkedin-square fa-2x',
    url: 'http://www.linkedin.com/in/RoboticCheese'
  }
}

@tapirgo_token = '530963f470fda80200000004'
