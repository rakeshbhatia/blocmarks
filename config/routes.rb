Rails.application.routes.draw do
  devise_for :users
  root 'pages#welcome'

  resources :topics, except: [:edit, :update]
end
