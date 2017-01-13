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

  scenario 'displays an average rating for all reviews' do
    create_review
    log_out
    sign_up_2
    create_review("Great", 5)
    expect(page).to have_content("Average rating: 4")
  end

end
