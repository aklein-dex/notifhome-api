Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
  
  resources :notifications
  
  resources :devices
  
  namespace :device do
    resources :notifications
  end
  
  
end
