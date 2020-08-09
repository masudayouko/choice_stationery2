Rails.application.routes.draw do
  devise_for :users
  root 'home#top'

  resources :users do
  	member do
      get :followings
      get :followers
    end
  end

  get '/search', to: 'search#search'
  resources :relationships, only: [:create, :destroy]

  resources :items do 
    resource :favorites, only: [:create, :destroy]
    resources :item_comments, only: [:create, :destroy]
  end
  get "items/rankings", to: "items#rankings"
end