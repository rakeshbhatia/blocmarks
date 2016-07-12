Rails.application.routes.draw do

  devise_for :users
  root 'pages#welcome'

  get 'topics/index'

  get 'topics/show'

  get 'topics/new'

  get 'topics/edit'

  get 'topics/index'

  get 'topics/show'

  get 'topics/new'

  get 'topics/edit'
end
