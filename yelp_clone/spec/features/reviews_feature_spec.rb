require 'rails_helper'
require 'web_helper'

feature 'reviewing' do
  before do
    sign_up
    create_restaurant
  end

  scenario 'allows users to leave a review using a form' do
     create_review
     expect(current_path).to eq '/restaurants'
     expect(page).to have_content('so so')
  end

  scenario 'user can not see Review link if they have not logged in' do
    log_out
    expect(page).not_to have_content('Review KFC')
  end

  scenario 'allows users to delete a review which they have created' do
    create_review
    click_link 'Delete KFC Review'
    expect(page).not_to have_content('so so')
  end

end
