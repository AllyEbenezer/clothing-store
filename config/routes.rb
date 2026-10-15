Rails.application.routes.draw do
  get "order/new"
  get "order/create"
  get "order/show"
  # Authentication
  devise_for :users

  # Products
  resources :products, only: [:index, :show]

  # Cart (singular resource)
  resource :cart, only: [:show], controller: 'cart'  do
    post :add
    patch :update
    delete :remove
  end

  # Orders
  resources :orders, only: [:new, :create, :show]

  # Root path
  root "products#index"
end
