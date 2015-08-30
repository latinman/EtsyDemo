Rails.application.routes.draw do

  devise_for :users
  resources :listings
  get "/seller" => "listings#seller"
  get "/about" => "pages#about"
  get "/contact" => "pages#contact"
  root "listings#index"
end
