Rails.application.routes.draw do
  devise_for :users, controllers:
    { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :homes, only: %i[index]
  resources :users, only: %i[edit update]
end
