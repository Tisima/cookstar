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
  resources :recipes, only: [:show, :index, :new, :create, :edit, :update, :destroy]
  resources :users, only: [:show, :index, :edit, :update]
   # 退会確認画面
  get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    # 論理削除用のルーティング
  patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
  get 'relationships/followings'
  get 'relationships/followers'
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end