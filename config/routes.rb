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
  get '/top_seller', to: 'main#top_seller', as: 'top_seller'
  get '/my_market', to: 'main#my_market' , as: 'main_my_market'
  get '/purchase_history', to: 'main#purchase_history' , as: 'main_purchase_history'
  get '/sale_history' , to: 'main#sale_history' , as: 'main_sale_history'
  get '/my_inventory', to: 'main#my_inventory', as: 'main_my_inventory'
  get '/calculate_market', to: 'main#calculate_market', as: 'cal_market'
  get '/search_category' , to: 'main#search_category', as: 'search_category'
  get '/delete_item', to: 'main#delete_item', as: 'delete_item'
  get '/edit_product', to: 'main#edit_product', as: 'edit_product'
  get '/edit', to: 'main#edit', as: 'edit'
  get '/add_product', to: 'main#add_product', as: 'add_product'
  get '/add', to: 'main#add', as: 'add'
  post '/update_password', to: 'main#update_password', as: 'update_password'
  post '/update_profile', to: 'main#update_profile', as: 'update_profile'
  post '/search_top', to: 'main#search_top', as: 'search_top'
  post '/create_user', to: 'main#create_user', as: 'create_user'
  post '/calculate_market', to: 'main#calculate_market', as: 'main_calculate_market'
  post '/search_category', to: 'main#search_category', as: 'main_search_category'
  post '/edit', to: 'main#edit'
  post '/add', to: 'main#add'
  post 'main/create'
  delete '/sign_out', to: 'main#sign_out', as: 'sign_out'
  match '*unmatched', to: 'application#not_found_method', via: :all
  # root "articles#index"
end
