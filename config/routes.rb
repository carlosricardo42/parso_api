require 'api_constraint'
Rails.application.routes.draw do
  resources :api_keys,  :except => [:edit, :update]
  # namespace :api, defaults: { format: :json },
  #                              constraints: { subdomain: 'api' }, path: '/'  do
  #   scope module: :v1, constraints: ApiConstraint.new(version: 1, default: true) do
      match '/find_duplicates', to: 'api_keys#find_duplicates', via: [:get, :post]#, on: :collection
    # end
    # end
  root to: 'api_keys#index'
end
