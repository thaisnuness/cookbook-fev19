require 'rails_helper'

feature 'User delete recipe' do
  scenario 'successfully' do
    user = User.create!(email: 'user1@email.com', password: 'user123')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)

    # simula a ação do usuário
    login_as user, scope: :user
    visit root_path
    click_on 'Bolo de cenoura'
    click_on 'Excluir'

    
    expect(current_path).to eq root_path
    expect(page).to have_content('Receita deletada com sucesso')
    expect(Recipe.count).to eq 0

  end

  scenario 'User delete one recipe' do
    user = User.create!(email: 'user1@email.com', password: 'user123')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)
    Recipe.create(title: 'Bolo de chocolate', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 45, ingredients: 'Farinha, açucar, chocolate',
                  cook_method: 'Derreta o chocolate, e misture com o restante dos ingredientes', user: user)
    
    #simula ação do usuário
    login_as user, scope: :user

    visit root_path
    click_on 'Bolo de chocolate'
    click_on 'Excluir'

    expect(current_path).to eq root_path
    expect(page).to have_content('Receita deletada com sucesso')
    expect(page).to have_content('Bolo de cenoura')
    expect(page).to_not have_content('Bolo de chocolate')
    expect(Recipe.count).to eq 1
  end
end