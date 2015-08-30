Rails.application.routes.draw do

  resources :listings
  get "/about" => "pages#about"
  get "/contact" => "pages#contact"
  root "listings#index"
end
