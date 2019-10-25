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
    @address = build_address(hash)
    @distance = hash[:distance]
    @fuel_types = hash[:fuel_type_code]
    @latitude = hash[:latitude]
    @longitude = hash[:longitude]
    @name = hash[:station_name]
  end

  private

  def build_address(hash)
    "#{hash[:street_address]}, #{hash[:city]}, #{hash[:state]} #{hash[:zip]}"
  end
end
