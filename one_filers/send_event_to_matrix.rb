require "logger"
require "bundler"
Bundler.require

def help
  puts "you got to pass some stuff bra"
  puts "test_event.rb <user_id> <type> <item_id>"
  puts "\ttypes are: view, cart, purchase"
  exit
end

help unless ARGV.length > 1

case ARGV[1].downcase
when "view"
  type = "view"
when "cart"
  type = "cart"
when "purchase"
  type = "purchase"
else
  help
end

class MatrixTest
  include HTTParty
  base_uri ENV["MATRIX_BASE_URI"]
  logger ::Logger.new "httparty.log"
end

route = "/streams/website_traffic001/indybrowns_org001/event"
content = { :body => [{ "user_id" => ARGV[0],
                        "session_id" => "cde456",
                        "type" => type,
                        "email" => ARGV[0] + "@indybrowns.org",
                        "item_id" => ARGV[2] || "" }
                     ].to_json,
            :headers => { "Authorization" => "Bearer #{ENV['API_KEY']}",
                          "Content-Type" => "application/json",
                          "Accept" => "application/json" }
}

# ap content

ap MatrixTest.post(route, content)
