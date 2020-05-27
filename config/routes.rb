Rails.application.routes.draw do
  resources :favorites
  resources :comments
  resources :user_subreddits
  resources :posts
  resources :subreddits
  resources :users

  get '/', to: 'home#index', as: 'home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/top', to: 'home#top', as: 'top'
  get '/least', to: 'home#least', as: 'least'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

end
