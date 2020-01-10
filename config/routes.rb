Rails.application.routes.draw do
  root to: 'users#new'
  resources :relationships, only: [:create, :destroy]
  resources :pictures do
    resources :comments
    collection do
      patch :confirm
      post :confirm
    end
    member do
      patch :confirm
    end
  end
  resources :users, only: [:index, :new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :conversations do
    resources :messages
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
