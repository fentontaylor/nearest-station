require 'rails_helper'

describe 'As a user' do
  context 'on the welcome page, I select a starting location and click "Find Nearest Station"' do
    it 'takes me to /search where I see station info and directions' do
      visit '/'

      select 'Turing', from: 'location'

      click_button 'Find Nearest Station'

      expect(current_path).to eq('/search')

      within('.station-info') do
        expect(page).to have_css('.station-name')
        expect(page).to have_content('Station name: Seventeenth Street Plaza')

        expect(page).to have_css('.station-address')
        expect(page).to have_content("Address: 1225 17th St., Denver, CO 80202")

        expect(page).to have_css('.station-fuel-type')
        expect(page).to have_content("Fuel types: ELEC")

        expect(page).to have_css('.station-distance')
        expect(page).to have_content("Distance: 0.0934 miles")

        expect(page).to have_css('.station-access-times')
        expect(page).to have_content("Access times: MO: Not Specified; TU: Not Specified; WE: Not Specified; TH: Not Specified; FR: Not Specified; SA: Not Specified; SU: Not Specified")
      end

      # I should also see:
      # - the distance of the nearest station
      # - the travel time from Turing to that fuel station (should be 0.1 miles)
      # - The HTML direction instructions to get to that fuel station
      #   "Head <b>southeast</b> on <b>17th St</b> toward <b>Larimer St</b>"
      within '.directions' do
        expect(page).to have_content('Head southeast on 17th St toward Larimer St')
        expect(page).to have_content('Turn left onto Lawrence St Destination will be on the left')
      end
    end
  end
end
