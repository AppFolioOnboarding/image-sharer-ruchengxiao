Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :images,  only: %i(index show new create)
  root 'application#home'
end
