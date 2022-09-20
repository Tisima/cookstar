class Public::LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :recipe_params, only: [:create, :destroy]

  def create
    Like.create(user_id: current_user.id, recipe_id: @recipe.id)
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, recipe_id: @recipe.id)
    like.destroy
  end

  private
  def recipe_params
    @recipe = Recipe.find(params[:recipe_id])
  end
end
