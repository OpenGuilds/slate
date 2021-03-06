# Unique header generation
require './lib/unique_head.rb'
require 'lib/wallet.rb'
require 'lib/batch.rb'
require 'lib/guild.rb'
require 'lib/member.rb'
require 'lib/task.rb'
require 'lib/dataset.rb'

helpers WalletHelper
helpers BatchHelper
helpers GuildHelper
helpers MemberHelper
helpers TaskHelper
helpers DatasetHelper

# Markdown
set :markdown_engine, :redcarpet
set :markdown,
    fenced_code_blocks: true,
    smartypants: true,
    disable_indented_code_blocks: true,
    prettify: true,
    strikethrough: true,
    tables: true,
    with_toc_data: true,
    no_intra_emphasis: true,
    renderer: UniqueHeadCounter

# Assets
set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :fonts_dir, 'fonts'


# Activate the syntax highlighter
activate :syntax
ready do
  require './lib/multilang.rb'
end

activate :sprockets

activate :autoprefixer do |config|
  config.browsers = ['last 2 version', 'Firefox ESR']
  config.cascade  = false
  config.inline   = true
end

# Github pages require relative links
activate :relative_assets
set :relative_links, true

# Build Configuration
configure :build do
  # If you're having trouble with Middleman hanging, commenting
  # out the following two lines has been known to help
  activate :minify_css
  activate :minify_javascript
  # activate :relative_assets
  # activate :asset_hash
  # activate :gzip
end

# Deploy Configuration
# If you want Middleman to listen on a different port, you can set that below
set :port, 4567

helpers do
  require './lib/toc_data.rb'

  def api_endpoint
    'https://dashboard.openguilds.com'
  end

  def list_for(object, path)
    {
      object:  "List",
      url: path,
      has_more: false,
      page: 1,
      data: object
    }
  end
end
