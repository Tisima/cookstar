class Public::RecipesController < ApplicationController
  def index
    @recipes = Recipe.all.page(params[:page])
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

    private
  def recipe_params
    params.require(:recipe).permit(:title, :body, :image)
  end
end