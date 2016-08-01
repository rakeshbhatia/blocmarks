Rails.application.routes.draw do
  devise_for :users
  root 'pages#welcome'

  resources :topics, except: [:edit, :update] do
    resources :bookmarks, except: [:index]
  end

  post :incoming, to: 'incoming#create'
end
