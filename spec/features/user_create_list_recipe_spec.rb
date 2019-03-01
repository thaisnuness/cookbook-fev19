require 'rails_helper'

feature 'User create list recipes' do
  scenario 'successfully' do
    user = User.create!(email: 'user1@email.com', password: 'user123')
    login_as user, scope: :user
    visit root_path

    click_on 'Criar Lista de Receitas'

    fill_in "Nome da lista", with: "Lista de natal"
    click_on 'Cadastrar'

    expect(page).to have_content('Lista criada com sucesso')
  end

  scenario 'user view recipes on list' do
    user = User.create!(email: 'user1@email.com', password: 'user123')
    list = List.create!(name: 'Lista de Natal', user: user)
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe1 = Recipe.create(title: 'Bolodecenoura', difficulty: 'Médio',
                            recipe_type: recipe_type, cuisine: cuisine,
                            cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)
    recipe2 = Recipe.create(title: 'Bolodechocolate', difficulty: 'Médio',
                            recipe_type: recipe_type, cuisine: cuisine,
                            cook_time: 45, ingredients: 'Farinha, açucar, chocolate',
                            cook_method: 'Derreta o chocolate, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)
    ListRecipe.create(list: list, recipe: recipe1)

    login_as user, scope: :user
    visit root_path
    click_on 'Ver minhas listas'

    click_on list.name

    expect(page).to have_css('h1', text: 'Lista de Natal')
    expect(page).to have_css('h2', text: 'Bolodecenoura')
    expect(page).to_not have_css('h2', text: 'Bolodechocolate')

  end

end