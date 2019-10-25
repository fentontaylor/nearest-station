require 'rails_helper'

describe 'As a user' do
  context 'on the welcome page, I select a starting location and click "Find Nearest Station"' do
    it 'takes me to /search where I see station info and directions' do
      # As a user
      # When I visit "/"
      visit '/'
      # And I select "Turing" form the start location drop down (Note: Use the existing search form)
      select 'Turing', from: 'location'
      # And I click "Find Nearest Station"
      click_button 'Find Nearest Station'
      # Then I should be on page "/search"
      expect(current_path).to eq('/search')
      # Then I should see the closest electric fuel station to me.
      within('.station-info') do
        expect(page).to have_css('.station-name')
        expect(page).to have_css('.station-address')
        expect(page).to have_css('.station-fuel-type')
        expect(page).to have_css('.station-distance')
        expect(page).to have_css('.station-access-times')
      end
      # For that station I should see
      # - Name
      # - Address
      # - Fuel Type
      # - Distance
      # - Access Times
      #
      # I should also see:
      # - the distance of the nearest station
      # - the travel time from Turing to that fuel station (should be 0.1 miles)
      # - The HTML direction instructions to get to that fuel station
      #   "Head <b>southeast</b> on <b>17th St</b> toward <b>Larimer St</b>"
    end
  end
end
