class ArticleBuilder
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

  def consume_feed
    count = 0
    @urls.each do |url|
      open(url) do |rss|
        feed = RSS::Parser.parse(rss)
        puts "RSS Title: #{feed.channel.title}"
        feed.items.each do |item|
          article = Article.new(item, @collect_db)
          article.save
          count += 1
          return if count == 5
        end
      end
    end
  end
end
