class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @users = @user.recipes.all
  end

  def index
  end
end
