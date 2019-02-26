require 'rails_helper'

feature 'User delete recipe' do
  scenario 'successfully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    Recipe.create(title: 'Bolo de chocolate', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 45, ingredients: 'Farinha, açucar, chocolate',
                  cook_method: 'Derreta o chocolate, e misture com o restante dos ingredientes')
    
  visit root_path
  fill_in 'Buscar', with: 'Bolo de chocolate'
  click_on 'Buscar'
  
  expect(page).to have_content('Bolo de chocolate')
  expect(page).to_not have_content('Bolo de cenoura')
  expect(Recipe.count).to eq 1


  end
end