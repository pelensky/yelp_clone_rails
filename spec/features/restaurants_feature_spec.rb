require 'rails_helper'

feature 'restaurants' do

  context 'when user is not logged in' do
     scenario 'the user should be redirected to the login page' do
       visit '/restaurants'
       click_link 'Add a restaurant'
       expect(page).to have_content "You need to sign in or sign up before continuing"
     end
   end

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurants' do
      sign_up
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      sign_up
      create_restaurant
    end
    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'promts user to fill out a form, then displays the new restaurant' do
      sign_up
      create_restaurant
      expect(current_path).to eq '/restaurants'
    end

    context 'an invalid restaurant' do
      scenario 'does not let you submit a name that is too short' do
        sign_up
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end

  context 'viewing restaurants' do

    scenario 'lets a user view a restaurant' do
      sign_up
      create_restaurant
      visit '/restaurants'
      click_link "KFC"
      expect(page).to have_content 'KFC'

    end
  end

  context 'editing restaurants' do

    scenario 'let a user edit a restaurant' do
      sign_up
      create_restaurant
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Deep fried goodness'
      click_button 'Update Restaurant'
      click_link 'Kentucky Fried Chicken'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content 'Deep fried goodness'
    end
  end


  context 'deleting restaurants' do

    scenario 'removes restaurant when a user clicks delete' do
      sign_up
      create_restaurant
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

end
