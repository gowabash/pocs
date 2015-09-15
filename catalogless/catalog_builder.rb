class CatalogBuilder

  def initialize
    @product_db = Mongo::MongoClient.new("localhost", 27017).db('product')
    @events = @product_db['Events.Test_crap']
    @products = @product_db['Products.Test_crap']
  end

  def build
    keys = @events.distinct('details.key')
    keys.each do |key|
      uri = URI.parse key
      path = uri.path
      page = /(\/.*)*\/(.*)$/.match(path)
      h = {:page => page[2], :key => key}
      ap h
    end
  end
end
