class StationDirectionsService
  def initialize(origin)
    @origin = origin
    @nrel_url = 'https://developer.nrel.gov/api/alt-fuel-stations/v1/nearest'
    @google_url = 'https://maps.googleapis.com/maps/api/directions/json'
  end

  def find_nearest_station
    return @station if @station
    response = fetch_nrel_data
    data = JSON.parse(response.body, symbolize_names: true)
    @station = Station.new(data[:fuel_stations].first)
  end

  def get_directions
    return @directions if @directions
    response = fetch_google_routes
    data = JSON.parse(response.body, symbolize_names: true)
    @directions = data[:routes].first[:legs].first[:steps].map do |step|
      ActionController::Base.helpers.strip_tags(step[:html_instructions])
    end
  end

  private

  def fetch_nrel_data
    Faraday.get(@nrel_url) do |req|
      req.params['api_key'] = ENV['NREL_KEY']
      req.params['location'] = @origin
      req.params['fuel_type'] = 'ELEC'
      req.params['format'] = 'json'
    end
  end

  def fetch_google_routes
    Faraday.get(@google_url) do |req|
      req.params['origin'] = @origin
      req.params['destination'] = @station.address
      req.params['key'] = ENV['GOOGLE_KEY']
    end
  end
end
