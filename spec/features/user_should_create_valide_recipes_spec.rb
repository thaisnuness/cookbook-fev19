require 'rails_helper'

feature 'User shold not create a recipe' do
  scenario 'with cook time zero' do 
    #simula ação do usuário
    visit new_recipe_path

    fill_in 'Título', with: 'Tabule'
    fill_in 'Tipo da Receita', with: 'Entrada'
    fill_in 'Cozinha', with: 'Arabe'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '0'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    click_on 'Enviar'
    
    # expectativa
    expect(page).to have_content('O tempo de preparo deve ser maior que 0')

  end

  scenario 'with negative cook time' do 
      #simula ação do usuário
      visit new_recipe_path

      fill_in 'Título', with: 'Tabule'
      fill_in 'Tipo da Receita', with: 'Entrada'
      fill_in 'Cozinha', with: 'Arabe'
      fill_in 'Dificuldade', with: 'Fácil'
      fill_in 'Tempo de Preparo', with: '-1'
      fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
      fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
      click_on 'Enviar'
      
      # expectativa
      expect(page).to have_content('O tempo de preparo deve ser maior que 0')
    
  end

end