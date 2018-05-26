Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {sessions: 'users/sessions'}
  
  resources :registrations do
  	collection do
  		get :index
  	end	
  end

  resources :dashboard do
    collection do
      get :index
    end
  end

  root 'home#index'

end
