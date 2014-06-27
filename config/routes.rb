Rails.application.routes.draw do
  root to: 'cats#index'
  resources :cats
  resources :cat_rental_requests do
    member do 
      post 'respond'
    end
  end
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
end
