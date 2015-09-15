require "bundler"
Bundler.require

es_query = {
  :query =>
  { :constant_score =>
    { :filter =>
      { :and =>
        [
          { :range =>
            { :last_datetime =>
              {
                :gte => "2014-09-09T18:00:00",
                :lte => "2014-09-09T18:05.00"
              }
            }
        },
          { :nested =>
            {
              :filter => { :exists => { :field => "page_views.sequence" } },
              :path => "page_views"
            }
        }
        ]
      }
    }
  }
}

es_client = Elasticsearch::Client.new(:hosts              => ["localhost:9202"],
                                      :randomize_hosts    => true,
                                      :reload_on_failure  => true,
                                      :retry_on_failure   => 3,
                                      :reload_connections => 1_000)

index = "wenner_20140909"
response = es_client.search(:index => index,
                            :type => "session",
                            :search_type => "scan",
                            :scroll => "5m",
                            :size => 100,
                            :body => es_query.to_json,
                            :ignore_unavailable => true)
scroll_id = response["_scroll_id"]

file = File.open("test.json", "w+")
loop do
  results = es_client.scroll(:body => scroll_id, :scroll => "5m")
  scroll_id = results["_scroll_id"]
  hits = results["hits"]["hits"]
  break if hits.count == 0
  hits.each do |hit|
    file.puts(hit)
  end
end
