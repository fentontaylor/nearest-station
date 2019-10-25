require 'rails_helper'

describe Station do
  before :each do
    json = File.read('./fixtures/nearest_elec_to_turing.json')
    data = JSON.parse(json, symbolize_names: true)
    @station = Station.new(data[:fuel_stations].first)
  end

  it 'can initialize with a hash' do

    expect(@station).to be_an_instance_of Station
  end

  it 'has attributes' do
    expect(@station.access_times).to eq('MO: Not Specified; TU: Not Specified; WE: Not Specified; TH: Not Specified; FR: Not Specified; SA: Not Specified; SU: Not Specified')
    expect(@station.address).to eq('1225 17th St., Denver, CO 80202')
    expect(@station.distance).to eq(0.0934)
    expect(@station.fuel_types).to eq('ELEC')
    expect(@station.latitude).to eq(39.7501605)
    expect(@station.longitude).to eq(-104.9951224)
    expect(@station.name).to eq('Seventeenth Street Plaza')
  end
end
