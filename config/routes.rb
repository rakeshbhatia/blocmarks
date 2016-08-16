Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]

  root 'pages#welcome'

  resources :topics, except: [:edit, :update] do
    resources :bookmarks, except: [:index]
  end

  resources :bookmarks, only: [] do
    resources :likes, only: [:index, :create, :destroy]
  end

  post :incoming, to: 'incoming#create'
end
