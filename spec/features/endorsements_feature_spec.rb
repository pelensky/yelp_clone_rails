require 'rails_helper'

feature 'endorsing reviews' do
  before do
    sign_up
    create_restaurant
    leave_review("terrible", 3)
    sign_out
  end

  scenario 'a user can endorse a review, which updates the review endorsement count' do
    sign_up_different_user
    visit '/restaurants'
    click_link 'Endorse Review'
    expect(page).to have_content('1 endorsement')
  end

end
