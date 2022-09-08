class Admin::AdminsController < ApplicationController
  def after_sign_in_path_for(_resource)
    recipes_path
  end
end
