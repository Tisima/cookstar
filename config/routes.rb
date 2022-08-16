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
  resources :recipes, only: [:show, :index, :new, :create]
  resources :members, only: [:show, :index]
  get 'relationships/followings'
  get 'relationships/followers'
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end