Rails.application.routes.draw do
  root 'pages#home'
  get 'pages/home'
  resources :questions, only: [:index, :update, :new, :edit, :create, :destroy]
  resources :users, except: [:new]
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :templates, only: [:index, :show, :destroy]
end
