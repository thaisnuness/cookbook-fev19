require 'rails_helper'

RSpec.describe RecipesMailer do
  describe '.notify_new_recipe' do
    it 'should send mail to admin' do 
      user = User.create!(email: 'user1@email.com', password: 'user123')
      recipe_type = RecipeType.create(name: 'Entrada')
      cuisine = Cuisine.create(name: 'Brasileira')
      recipe = Recipe.create(title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)
      
      mail = RecipesMailer.notify_new_recipe(recipe.id)

      expect(mail.to).to include('admin@cookbook.com.br')
    end

    it 'shoud have the correct subject' do
      user = User.create!(email: 'user1@email.com', password: 'user123')
      recipe_type = RecipeType.create(name: 'Entrada')
      cuisine = Cuisine.create(name: 'Brasileira')
      recipe = Recipe.create(title: 'Bolodecenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)
      
      mail = RecipesMailer.notify_new_recipe(recipe.id)

      expect(mail.subject).to eq("Nova receita cadastrada: #{recipe.title}")
    end
  end
end