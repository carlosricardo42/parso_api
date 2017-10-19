Rails.application.routes.draw do
  resources :api_keys,  :except => [:edit, :update]
  match '/find_duplicates', to: 'api_keys#find_duplicates', via: [:get, :post]#, on: :collection
  root to: 'api_keys#index'
end
