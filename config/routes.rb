require 'sidekiq/web'

Rails.application.routes.draw do
  resources :states

  mout Sidekiq::web => '/sidekiq'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/client", to: "clients#index"
  # Defines the root path route ("/")
  root "states#index"
end
