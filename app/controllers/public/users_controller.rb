class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.page(params[:page])
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
  if @user.update(user_params)
    flash[:notice]="ユーザ情報を更新しました！"
    redirect_to user_path(@user.id)
  else
    render :edit
  end
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

  def likes
    @user = User.find(params[:id])
    recipes= Recipe.where(user_id: @user.id).pluck(:id)
    @like_recipes = Recipe.find(recipes)
  end

  def search
    @users = User.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end

    private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
