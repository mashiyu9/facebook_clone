Rails.application.routes.draw do
  # root 'user#new'
  resources :pictures do
    collection do 
      patch :confirm
      post :confirm
    end
    member do 
      patch :confirm 
    end    
  end
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]

  root to: 'users#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
