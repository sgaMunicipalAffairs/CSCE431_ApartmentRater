Rails.application.routes.draw do
  get 'home/index'
  get 'misc/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  root 'apartments#index'
  resources :apartments
  get 'apartment_list', to: 'apartments#apartment_list', as: 'apartment_list'
  resources :reviews
  get 'review_list', to: 'reviews#review_list', as: 'review_list'
  resources :users
  resources :tags
  resources :metrics
  resources :amenities


  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'admin', to: 'users#admin_portal', as: 'admin_only'
  get 'add_admin', to: 'users#admin', as: 'add_admin'
end
