Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :registrations do
  	collection do
  		get :index
  	end	
  end

  root 'home#index'

end
