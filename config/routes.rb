Rails.application.routes.draw do

  root to: 'static_pages#home'
  get    'signup', to: 'users#new'
  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  
  resources :users do
    member do
      get 'followings'
      get 'followers'
      get 'favorites'
    end
  end
  resources :microposts # do
  #  member do
  #    post 'like' #microposts/:id/like
  #  end
  #end
  resources :relationships, only: [:create, :destroy]
  
  resources :favorites, only: [:create, :destroy]
end
