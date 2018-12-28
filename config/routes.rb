Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'sessions#new'
  get  '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/password_reset/:id/reset_password', to: 'teams#edit_password', as: 'reset_password'
  patch '/password_reset/:id', to: 'teams#reset_password', as: 'password_reset'

  resources :teams
    resources :places


end
