class Public::LikesController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    like = current_user.likes.new(recipe_id: @recipe.id)
    like.save
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    like = current_user.likes.find_by(recipe_id: @recipe.id)
    like.destroy
  end
end
