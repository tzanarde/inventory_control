Rails.application.routes.draw do
  resources :users
  resources :clients
  resources :categories
  resources :products
end
