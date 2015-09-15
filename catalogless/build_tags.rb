require 'bundler/setup'
Bundler.require

require 'rss'
require 'open-uri'
require 'uri'
require 'json'

require './article'
require './click_setup'
require './catalog_builder'
require './article_builder'

require '../alchemyapi_ruby/alchemyapi'

#clicker = ClickSetup.new
#clicker.write_articles
#clicker.do_some_clicks
#builder = CatalogBuilder.new
#builder.build
#
builder = ArticleBuilder.new
builder.consume_feed


