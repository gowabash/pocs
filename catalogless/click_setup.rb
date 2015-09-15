class ClickSetup
  COLLECT_URL = "http://collect.dev/c2/event"

  def initialize
    @urls = ["http://www.rollingstone.com/siteServices/rss/allNews",
      "http://www.rollingstone.com/siteServices/rss/musicNewsAndFeature",
      "http://www.rollingstone.com/siteServices/rss/movieNewsAndFeature",
      "http://www.rollingstone.com/siteServices/rss/cultureNewsAndFeature",
      "http://www.rollingstone.com/siteServices/rss/politicsNewsAndFeature",
    ]
    @collect_db = Mongo::MongoClient.new("localhost", 27017).db('collect')
    @articles = @collect_db['articles']
  end

  def write_articles
    @urls.each do |url|
      open(url) do |rss|
        feed = RSS::Parser.parse(rss)
        puts "RSS Title: #{feed.channel.title}"
        feed.items.each do |item|
          article = Article.new(item, @collect_db)
          article.save
        end
      end
    end
  end

  def do_some_clicks
    total_articles = @articles.count()
    2000.times do |x|
      random_num = Random.rand(total_articles)
      main_article = @articles.find({}, {:limit => 1, :skip => random_num} ).first
      log_these = @articles.find({'keywords' => {'$in' => main_article['keywords']}}).to_a
      Random.rand(5).times do |y|
        log_these << (@articles.find({}, {:limit => 1, :skip => Random.rand(total_articles)}).first)
      end
      log_these.each do |please|
        user_id = "user" + x.to_s
        session_id = "session" + x.to_s
        doc = {
          :name => 'view',
          :user_id => user_id,
          :session_id => session_id,
          :keywords => please['keywords'],
          :key => URI.escape(please['link']),
        }
        HTTParty.post(COLLECT_URL+"?retailer=test_crap", :body => doc.to_json)
      end
    end
  end
end
