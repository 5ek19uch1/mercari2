Rails.application.routes.draw do
   #devise周り
  devise_for :users, :controllers => {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
}
  root 'mains#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get 'signup/index' => "users/registrations#index"
    post "signup/phone_number" => "users/registrations#phone_number"
    post "signup/address" => "users/registrations#address"
    post "signup/credit" => "users/registrations#credit"
    post "signup/card" => "users/registrations#card"

    end
end
