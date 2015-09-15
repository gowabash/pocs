require 'bundler'
Bundler.require

def insert_data
  mongo = Mongo::MongoClient.new("localhost")["geo"]
  geo = GeoIP.new('./GeoIPCity.dat')
  count = 0
  geo.each do |city|
    begin
      data = city.to_hash 
      data[:city_name].encode!("UTF-8", "iso-8859-1")
      data[:gps] = {
        :type => "Point", 
        :coordinates => [city[:longitude], city[:latitude] ]
      }
      mongo["Cities"].insert(data)
      #break if count == 1000
      #count += 1
    rescue Exception => e
      ap data
      ap e
    end
  end
end

def sample_query
  mongo = Mongo::MongoClient.new("localhost")["geo"]
  response = mongo.command(
    {
     :geoNear =>  'Cities', 
      :spherical => true, 
      :num => 1, 
      :distanceMultiplier => 3.28 / 5280,
      :near => 
      { 
        :type => "Point", 
        :coordinates => [-87.41, 39.95] 
      }
  })

  ap response["results"].first
end

sample_query
