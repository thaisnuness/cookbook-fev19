require 'rails_helper'

feature 'User mark featured recipe' do
  scenario 'successfully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    new_recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', featured: false)
    
    visit recipe_path(new_recipe)
    click_on 'Destaque'
    
    new_recipe.reload
    within 'div#featured' do
      expect(page).to have_css('h1', text: new_recipe.title)
    end
    #expect(new_recipe.featured).to eq true
    expect(new_recipe).to be_featured
  end

  scenario 'unfeatured' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    new_recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', featured: true)
    
    visit recipe_path(new_recipe)
    click_on 'Remover Destaque'
    
    new_recipe.reload
    within 'div#featured' do
      expect(page).to have_css('p', text: 'Nenhuma receita em destaque')
    end
  
    within 'div#other_recipes' do
      expect(page).to have_css('h1', text: new_recipe.title)
    end
    #expect(new_recipe.featured).to eq true
    expect(new_recipe).not_to be_featured
  end
end