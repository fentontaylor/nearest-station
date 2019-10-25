class Station
  attr_reader :access_times,
              :address,
              :distance,
              :fuel_types,
              :latitude,
              :longitude,
              :name
              
  def initialize(hash)
    @access_times = hash[:access_days_time]
    @address = hash[:street_address]
    @distance = hash[:distance]
    @fuel_types = hash[:fuel_type_code]
    @latitude = hash[:latitude]
    @longitude = hash[:longitude]
    @name = hash[:station_name]
  end
end
