Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'doctors/index'
  get 'patients/index'
  root 'home#index'
  devise_for :admins
  devise_for :doctors
  devise_for :patients
  resources :patients do
    collection do
      get 'dashboard'
    end
  end
  resources :appointments do
    member do
      patch 'accept_appointment'
      patch 'reject_appointment'
    end
  end
  resources :doctors do
    collection do
      get 'dashboard'
    end
  end
end
