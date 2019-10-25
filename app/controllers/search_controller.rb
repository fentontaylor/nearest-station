class SearchController < ApplicationController
  def index
    origin = params['location']
    root_url = 'https://developer.nrel.gov/api/alt-fuel-stations/v1/nearest'

    response = Faraday.get(root_url) do |req|
      req.params['api_key'] = ENV['NREL_KEY']
      req.params['location'] = origin
      req.params['fuel_type'] = 'ELEC'
      req.params['format'] = 'json'
    end

    data = JSON.parse(response.body, symbolize_names: true)
    @station = Station.new(data[:fuel_stations].first)

    google_url = 'https://maps.googleapis.com/maps/api/directions/json'

    g_response = Faraday.get(google_url) do |req|
      req.params['origin'] = origin
      req.params['destination'] = @station.address
      req.params['key'] = ENV['GOOGLE_KEY']
    end

    g_data = JSON.parse(g_response.body, symbolize_names: true)
    @directions = g_data[:routes].first[:legs].first[:steps].map do |step|
      ActionController::Base.helpers.strip_tags(step[:html_instructions])
    end
  end
end
