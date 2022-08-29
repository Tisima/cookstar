class Admin::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.page(params[:page])
  end

  def index
    @users = User.all
  end

  def unsubscribe
    @user = User.find_by(name: params[:name])
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update!(is_deleted: true)
    reset_session
    redirect_to root_path
  end
end
