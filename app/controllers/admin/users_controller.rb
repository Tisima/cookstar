class Admin::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.page(params[:page])
  end

  def index
    @users = User.all
  end

  def search
  @users = User.search(params[:keyword])
  @keyword = params[:keyword]
  render "index"
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update!(is_deleted: true)
    reset_session
    redirect_to admin_users_path
  end
end
