require 'rails_helper'

feature 'Admin register cusine' do
  scenario 'successfully' do
    visit root_path
    click_on 'Cadastrar tipo de cozinha'
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Brasileira')
  end

  scenario 'and must fill in name' do
    visit new_cuisine_path
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar o nome do tipo de cozinha')
  end
  
  scenario 'Not accepted duplicate cuisine type' do
    #Cadastro duplicado
    Cuisine.create(name: 'Brasileira')
    visit new_cuisine_path
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(page).to have_content('O nome informado já existe!')

  end

end