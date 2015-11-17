require "bundler"
Bundler.require

require "automatic"

# The following values are needed in .env file
# API_HOST
# AUTOMATIC_ACCESS_TOKEN
# AUTOMATIC_SECRET
# CLIENT_ID
# AUTOMATIC_APP_LOGGER
# AUTOMATIC_REQUEST_LOGGER
# AUTOMATIC_CACHE_LOGGER

trips = Automatic::Models::Trips.all

trips.each do |trip|
  puts "trip.user #{trip.user.full_name}"
  puts "trip.vehicle #{trip.vehicle.full_name}"
  puts "trip.start_location #{trip.start_location.coordinates}"
  puts "trip.start-at #{trip.start_at}"
  puts "trip.end_location #{trip.end_location.coordinates}"
  puts "trip.end_at #{trip.end_at}"
  # puts "trip.distance #{trip.distance}"
  puts "trip.fuel_cost #{trip.fuel_cost}"
  puts "trip.fuel_volume #{trip.fuel_volume}"
  puts "trip.average_mpg #{trip.average_mpg}"
  puts "trip.elapsed_time #{trip.elapsed_time}"

  # ap trip.attributes
  # ap trip.polyline.decoded
end
