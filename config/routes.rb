Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :trip do
    member do
      post :submit_location
    end
  end

end
