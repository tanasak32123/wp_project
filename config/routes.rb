Rails.application.routes.draw do
  resources :markets
  resources :inventories
  resources :items
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get '/login', to: 'main#login', as: 'main_login'
  get '/main', to: 'main#main', as: 'main_main'
  get '/profile', to: 'main#profile', as: 'main_profile'
  get '/new_account', to: 'main#new_account', as: 'new_account'
  get '/new_password', to: 'main#new_password', as: 'new_password'
  get '/new_profile', to: 'main#new_profile', as: 'new_profile'
  post '/update_password', to: 'main#update_password', as: 'update_password'
  post '/update_profile', to: 'main#update_profile', as: 'update_profile'
  post '/find_user', to: 'main#find_user', as: 'find_user'
  post '/create_user', to: 'main#create_user', as: 'create_user'
  post 'main/create'
  delete '/sign_out', to: 'main#sign_out', as: 'sign_out'
  match '*unmatched', to: 'application#not_found_method', via: :all
  # root "articles#index"
end
