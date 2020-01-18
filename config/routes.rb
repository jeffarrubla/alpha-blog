Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #get 'pages/home', to: 'pages#home' # if not root, use this form
  root 'pages#home' 
  # get 'pages/about', to: 'pages#about' if not related to root
  get 'about', to: 'pages#about'

  resources :articles # give article path (DELETE; UPDATE; INDEX; CREATE)

  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
