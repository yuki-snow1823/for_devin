Rails.application.routes.draw do
  devise_for :users
  root 'rooms#index'

  # get '/auth/:provider/callback', to: 'sessions#create'
  # delete '/logout', to: 'sessions#destroy'

  resources :rooms, only: [:index, :create, :show]
  resources :players, only: [:update]
  resources :responses, only: [:create]
end
