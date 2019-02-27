require 'rails_helper'

feature 'User search recipe' do
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
  
  expect(page).to have_css('h2', text: 'Bolo de chocolate')
  expect(page).to_not have_content('Bolo de cenoura')
  end


  scenario 'by a therm ' do
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
    fill_in 'Buscar', with: 'Bolo'
    click_on 'Buscar'
    
    expect(page).to have_css('h2', text: 'Bolo de chocolate')
    expect(page).to have_css('h2', text: 'Bolo de cenoura')
    expect(page).to have_content('2 receitas encontradas')
  end

  scenario 'dont exist ' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    
    visit root_path
    fill_in 'Buscar', with: 'Macarrão'
    click_on 'Buscar'
    
    expect(page).to have_css('p', text: 'Nenhuma receita encontrada')

  end

end