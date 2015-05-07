# Rails.application.routes.draw do

#   # get 'applications/index'

#   # get 'applications/show'

#   # get 'applications/new'

#   # get 'applications/edit'

#   resources :stocks
 

#   resources :portfolios do
#      resources :stocks, except: [:index]
#   end

  

#   devise_for :users
#   get 'welcome/index'

#   get 'welcome/about'

#   get 'portfolios' => 'welcome/portfolios#index'



#     root to: 'welcome#index'

# end


Rails.application.routes.draw do
  
  devise_for :users
  resources :users, only: [:update, :show]
  
  resources :portfolios do
    resources :stocks, only: [:create, :destroy]
  end

  namespace :api, defaults: { format: :json } do
    resources :stocks, only: [:create]
    match 'stocks' => "stocks#create", via: :options, as: :stocks_alternatives
  end

  authenticated :user do
    root to: "portfolios#index", as: :authenticated_root, via: :get
  end

  unauthenticated do
    root 'welcome#index'
  end

end




 

