Rails.application.routes.draw do
  root to: 'cats#index'
  resources :cats
  resources :cat_rental_requests do
    member do 
      post 'respond'
    end
  end
  resources :user, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
end
