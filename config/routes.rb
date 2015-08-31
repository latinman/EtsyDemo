Rails.application.routes.draw do

  devise_for :users
  resources :listings do
    resources :orders, only: [:new, :create]
  end
  get "/seller" => "listings#seller"
  get "/about" => "pages#about"
  get "/contact" => "pages#contact"
  get "/sales" => "orders#sales"
  get "/purchases" => "orders#purchases"
  root "listings#index"
end
