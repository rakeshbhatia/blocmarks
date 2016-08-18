Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show] do
    resources :bookmarks, only: [:show]
  end

  root 'pages#welcome'

  resources :topics, except: [:edit, :update] do
    resources :bookmarks, except: [:index, :show]
  end

  resources :bookmarks, only: [] do
    resources :likes, only: [:index, :create, :destroy]
  end

  resources :bookmarks, only: [] do
    resources :likes, only: [:index, :create, :destroy]
  end

  post :incoming, to: 'incoming#create'
end
