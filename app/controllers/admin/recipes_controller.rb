class Admin::RecipesController < ApplicationController
  def index
    @recipes = Recipe.all.page(params[:page]).order(created_at: :desc)
  end

  def show
    @recipe = Recipe.find(params[:id])
    @user = @recipe.user
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def search
    @recipes = Recipe.search(params[:keyword]).page(params[:page])
    @keyword = params[:keyword]
    render 'index'
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end
end
