Rails.application.routes.draw do

  resources :accesses
  resources :teams do
    resources :projects
    resources :events
  end

  resources :projects do
    resources :todos do
      resources :comments
    end
  end


 
  root to: 'home#index'

   Rails.application.routes.draw do
  get 'comments/index'

    devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
