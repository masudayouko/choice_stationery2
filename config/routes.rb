Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  

  resources :users do
      resource :relationships, only: [:create, :destroy]
      get 'follows' => 'relationships#follower', as: 'follows'
      get 'followers' => 'relationships#followed', as: 'followers'
  end

  resources :items do
    resource :favorites, only: [:create, :destroy]
    resources :item_comments, only: [:create, :destroy]
  end
    get 'item/rankings' => 'items#rankings'
    post 'tags/:tag', to: 'items#search_tags', as: :tag
    get 'search' => 'search#search'
end