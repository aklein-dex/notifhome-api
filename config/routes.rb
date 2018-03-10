Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
  
  resources :notifications, only: [:index, :create]
  
  resources :devices, only: [:show, :update, :create, :destroy]
  
  namespace :device do
    resources :notifications, only: [:index]
  end
  
  
end
