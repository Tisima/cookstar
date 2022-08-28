Rails.application.routes.draw do
# ユーザー用
 devise_for :users, skip: [:passwords], controllers: {
   registrations: "public/registrations",
   sessions: 'public/sessions'
 }

# 管理者用
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

root "homes#top"
get 'homes/about'
post '/homes/guest_sign_in', to: 'homes#guest_sign_in'

scope module: :public do
  resources :users, only: [:show, :index, :edit, :update]
  get 'unsubscribe/:name' => 'users#unsubscribe', as: 'confirm_unsubscribe'
  patch ':id/withdraw/:name' => 'users#withdraw', as: 'withdraw_user'
  put 'withdraw/:name' => 'users#withdraw'
  get 'search' => 'recipes#search'
  get 'ranking' => 'recipes#ranking'
  resources :recipes, only: [:show, :index, :new, :create, :edit, :update, :destroy] do
   resources :likes, only: [:create, :destroy]
  end
end

namespace :admin do
 resources :recipes, only: [:show, :index, :edit, :update, :destroy]
 resources :users, only: [:show, :index, :edit, :update]
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end