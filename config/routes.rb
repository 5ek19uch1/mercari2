Rails.application.routes.draw do

  get 'category/index'
  devise_for :users,
  controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks',
    confirmations: "users/confirmations"
}

devise_scope :user do
  get 'emailpass' => "users/registrations#emailpass"
  get "signup/credit" => "users/registrations#credit"
  get "signup/card" => "users/registrations#card"
  get "world/:id" =>  "users/registrations#world"
  end
  root 'mains#index'
  get 'search', to: 'mains#search'

  # トップページのカテゴリ取得用です
  get "category_children" , to: 'mains#category_children', defaults: { format: 'json' }
  get "category_grandchildren" , to: 'mains#category_grandchildren', defaults: { format: 'json' }


  
  get 'users/logout'
  get 'users/phone_confirmation' => 'users#phone_confirmation'
  get 'users/credit_new'
  get 'users/profile' => 'users#profile'
  get 'users/email_password' => 'users#email_password'
  get 'users/index'
  get 'users/:id' => 'users#regist'
  get 'users/:id' => 'users#show'
  get 'users/products/:id' => 'users#products_details'
  get 'card/new'
  get 'card/show'
  get 'card/add' 
  
  
  

  # collectionはカテゴリー習得用です
  resources :products do
    collection do
     get 'get_children', defaults: { format: 'json' }
     get 'get_grand_children', defaults: { format: 'json' }
     get "products/:id" => "products#update"
     get  'buy_edit/:id'=>  'products#buy_edit', as: 'buy_edit'
     post 'pay/:id' => 'products#pay', as: 'pay'
    end
    member do
      get 'get_children', defaults: { format: 'json' }
      get 'get_grand_children', defaults: { format: 'json' }
      delete "image_easy" => "products#image_easy"
    end
  end


  # 中島エリア Don't touch!!＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

  #Pay.jp関連>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  resources :card, only: [:new, :show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
      post 'buy', to: 'card#buy'
    end
  end
  #<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  resources :addresses,only: [:new, :create]

  resources :phonenumbers,only: [:new, :create]

  resources :category,only: [:index]

  #devise周り
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html




    resources :users, only: [:index, :show, :destroy] do
      collection do

      end
      get :logout
      get :credit
      get :credit_new
      get :status_selling
      get :status_trading
      get :status_sold

     end
  end
  # 中島エリア Don't touch!!＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

