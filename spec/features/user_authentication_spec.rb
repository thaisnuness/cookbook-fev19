require 'rails_helper'

feature 'user authentication' do
  scenario 'successfully' do
    User.create!(email: 'user1@email.com', password: 'user123')

    visit root_path
    click_on 'Log in'
    

    fill_in 'Email', with: 'user1@email.com'
    fill_in 'Password', with: 'user123' 
    within 'div.actions' do
      click_on 'Log in'
    end

    expect(current_path).to eq (root_path)
    expect(page).to have_content('Signed in successfully.')  
    expect(page).to have_link('Logout')
    expect(page).not_to have_link('Log in')

  end

  scenario 'user logout' do
    User.create!(email: 'user1@email.com', password: 'user123')
    
    visit root_path
    click_on 'Log in'
    
    fill_in 'Email', with: 'user1@email.com'
    fill_in 'Password', with: 'user123' 
    within 'div.actions' do
      click_on 'Log in'
    end
    
    click_on 'Logout'
    
    expect(current_path).to eq (root_path)
    expect(page).to have_content('Signed out successfully.')
    expect(page).to have_link('Log in')
    expect(page).not_to have_link('Logout')
  end

end
