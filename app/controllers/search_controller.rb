class SearchController < ApplicationController
  def index
    location = params['location']
    root_url = 'https://developer.nrel.gov/api/alt-fuel-stations/v1/nearest'
    response = Faraday.get(root_url) do |req|
      req.params['api_key'] = ENV['NREL_KEY']
      req.params['location'] = location
      req.params['fuel_type'] = 'ELEC'
      req.params['format'] = 'json'
    end

    data = JSON.parse(response.body, symbolize_names: true)
    @station = Station.new(data[:fuel_stations].first)
    binding.pry
  end
end
