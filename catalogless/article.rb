require 'digest'

class Article
  attr :title, :link, :publish, :author, :keywords, :alchemy_keywords, :concepts, :id

  def initialize(item, db)
    @db = db
    @title = item.title
    @link = item.link
    @publish = item.pubDate
    @author = item.dc_creator
    @id = Digest::SHA1.hexdigest @link
    doc = get_doc
    get_keywords(doc)
    alchemize(doc)
  end

  def save
    @db['articles'].save({:_id => @id,
                         :title => title,
                         :link => link,
                         :publish_date => publish,
                         :author => author,
                         :keywords => keywords,
                         :alchemy_keywords => alchemy_keywords,
                         :concepts => concepts
    })
  end

  def get_doc
    ap @link
    site = HTTParty.get(@link)
    doc = Nokogiri::HTML(site.body)
  end

  def get_keywords(doc)
    keywords = doc.at('meta[name="news_keywords"]/@content')
    @keywords = keywords.value.split(',') if keywords
  end

  def alchemize(doc)
    alchemyapi = AlchemyAPI.new()

    response = alchemyapi.text('url', @link)
    alchemy_text = response['text']

    #node = doc.xpath "//div[@id='storyTextContainer']"
    #response = alchemyapi.keywords('text', node.first.text, { 'sentiment'=>1 })
    #keywords = {}
    #if response['status'] == 'OK'
      #response['keywords'].map{|x| keywords[x['text']] = x['relevance']}
    #end  
    #ap keywords
    response = alchemyapi.keywords('text', alchemy_text, { 'sentiment'=>1 })
    @alchemy_keywords = {}
    if response['status'] == 'OK'
      response['keywords'].map{|x| @alchemy_keywords[x['text']] = x['relevance']}
    end  
    ap keywords
    @concepts = {}
    response = alchemyapi.concepts('text', alchemy_text)
    if response['status'] == 'OK'
      response['concepts'].map{|x| @concepts[x['text']] =  x['relevance']}
    end  
    ap concepts
  end
end
