require 'rails_helper'

feature 'reviews' do

  scenario 'allows users to leave a review' do
    sign_up
    create_restaurant
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'displays an average rating for all reviews' do
    sign_up
    create_restaurant
    leave_review('So so', '3')
    sign_out
    sign_up_different_user
    leave_review('Great', '5')
    expect(page).to have_content('Average rating: 4')
  end
end
