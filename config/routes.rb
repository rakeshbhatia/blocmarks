Rails.application.routes.draw do
  get 'likes/index'

  devise_for :users
  resources :users, only: [:show]

  root 'pages#welcome'

  resources :topics, except: [:edit, :update] do
    resources :bookmarks, except: [:index]
      resources :likes, only: [:index, :create, :destroy]
  end

  resources :bookmarks, only: [] do
    resources :likes, only: [:index, :create, :destroy]
  end

  post :incoming, to: 'incoming#create'
end
