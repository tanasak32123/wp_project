Rails.application.routes.draw do
  get '/login' , to: 'main#login' , as: 'main_login'
  post '/calculate_market', to: 'main#calculate_market', as: 'main_calculate_market'
  get '/profile', to: 'main#profile' , as: 'main_profile'
  get '/main', to: 'main#main', as: 'main_main'
  get '/my_market', to: 'main#my_market' , as: 'main_my_market'
  get '/purchase_history', to: 'main#purchase_history' , as: 'main_purchase_history'
  get '/sale_history' , to: 'main#sale_history' , as: 'main_sale_history'
  get '/my_inventory', to: 'main#my_inventory', as: 'main_my_inventory'
  get '/top_seller', to: 'main#top_seller', as: 'main_top_seller'
  get '/calculate_market', to: 'main#calculate_market', as: 'cal_market'
  get '/search_category' , to: 'main#search_category', as: 'search_category'
  post '/search_category', to: 'main#search_category', as: 'main_search_category'
  get '/delete_item', to: 'main#delete_item', as: 'delete_item'
  get '/edit_product', to: 'main#edit_product', as: 'edit_product'
  get '/edit', to: 'main#edit', as: 'edit'
  post '/edit', to: 'main#edit'
  get '/add_product', to: 'main#add_product', as: 'add_product'
  get '/add', to: 'main#add', as: 'add'
  post '/add', to: 'main#add'
  resources :markets
  resources :inventories
  resources :users
  resources :items
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end


# get 'main/login' , to: 'main#login' , as: 'main_login'
# post 'main/calculate_market', to: 'main#calculate_market', as: 'main_calculate_market'
# get 'main/profile', to: 'main#profile' , as: 'main_profile'
# get 'main/main', to: 'main#main', as: 'main_main'
# get 'main/my_market', to: 'main#my_market' , as: 'main_my_market'
# get 'main/purchase_history', to: 'main#purchase_history' , as: 'main_purchase_history'
# get 'main/sale_history' , to: 'main#sale_history' , as: 'main_sale_history'
# get 'main/my_inventory', to: 'main#my_inventory', as: 'main_my_inventory'
# get 'main/top_seller', to: 'main#top_seller', as: 'main_top_seller'
# get 'main/calculate_market', to: 'main#calculate_market', as: 'cal_market'
# get 'main/search_category' , to: 'main#search_category', as: 'search_category'
# post 'main/search_category', to: 'main#search_category', as: 'main_search_category'