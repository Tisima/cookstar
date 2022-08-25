class Public::RecipesController < ApplicationController
  def index
    @recipes = Recipe.all.page(params[:page])
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to recipe_path(@recipe.id)
      flash[:success] = "商品を登録しました"
    else
      render 'new'
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

    private
  def recipe_params
    params.require(:recipe).permit(:title, :body, :image, :ingredients)
  end
end