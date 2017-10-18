Rails.application.routes.draw do
  resources :api_keys
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'api_keys#index'
end
