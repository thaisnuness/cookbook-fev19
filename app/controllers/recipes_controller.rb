class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @recipes = Recipe.all
    @recipe_featured = Recipe.where(featured: true)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
    @recipe_types = RecipeType.all
    @cuisine = Cuisine.all
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save 
      redirect_to @recipe
    else
      @recipe_types = RecipeType.all 
      @cuisine = Cuisine.all
      render 'new'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:errors] = "Receita deletada com sucesso"
    redirect_to root_path
  end

  def edit    
    @recipe = Recipe.find(params[:id]) 
    @recipe_types = RecipeType.all 
    @cuisine = Cuisine.all
    if @recipe.user != current_user  
      flash[:errors] = "Acesso negado!"  
      redirect_to root_path
    end      
  end

  def update
    @recipe = Recipe.find(params[:id]) 
    if @recipe.update(recipe_params)      
      redirect_to @recipe
    else
      @recipe_types = RecipeType.all 
      @cuisine = Cuisine.all
      render 'edit'
    end
  end

  def search
    @recipes = Recipe.where("title LIKE '%#{params[:q]}%'")
  end

  def featured
    @recipe = Recipe.find(params[:id]) 
    @recipe.update(featured: true)
    redirect_to root_path
  end

  def unfeatured
    @recipe = Recipe.find(params[:id]) 
    @recipe.update(featured: false)
    redirect_to root_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty,
                                   :cook_time, :ingredients, :cook_method, :photo, :featured, :user_id)
  end
end
