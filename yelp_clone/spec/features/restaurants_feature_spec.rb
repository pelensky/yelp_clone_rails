require 'rails_helper'
require 'web_helper'

feature 'restaurants' do

  context 'no restaurants have been added' do

    scenario 'should display a prompt to add a restaurant' do
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

   scenario 'display restuarants' do
     visit '/restaurants'
     expect(page).to have_content("KFC")
     expect(page).not_to have_content ('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      sign_up
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'user cannot create a restaurant with the same name of an existing restaurant' do
      sign_up
      create_restaurant
      create_restaurant
      expect(page).to have_content 'Name has already been taken'
    end
  end

  context 'viewing restaurants' do

    before do
      sign_up
      create_restaurant
    end

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(page).to have_content 'Deep fried goodness'
    end
  end

  context 'editing restaurants' do

    before do
      sign_up
      create_restaurant
    end

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Deep fried goodness'
      click_button 'Update Restaurant'
      click_link 'Kentucky Fried Chicken'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content 'Deep fried goodness'
    end

    scenario 'users cannot edit a restaurant they did not create' do
      log_out
      sign_up_2
      visit '/restaurants'
      expect(page).not_to have_content 'Edit KFC'
    end
  end

  context 'deleting restaurants' do

      before do
        sign_up
        create_restaurant
      end

      scenario 'removes a restaurant when a user clicks a delete link' do
        visit '/restaurants'
        click_link 'Delete KFC'
        expect(page).not_to have_content 'KFC'
        expect(page).to have_content 'Restaurant deleted successfully'
      end

      scenario 'User cannot delete a restaurant they did not create' do
        log_out
        sign_up_2
        visit '/restaurants'
        expect(page).not_to have_content 'Delete KFC'
      end
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
