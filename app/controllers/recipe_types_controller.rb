class RecipeTypesController < ApplicationController
  def index
    @recipe_type = RecipeType.all
  end

  def show
    @recipe_type = RecipeType.find(params[:id])
  end

  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.create(recipe_type_params)
    redirect_to @recipe_type
  end

  private

  def recipe_type_params
    params.require(:recipe_type).permit(:name)
  end
end