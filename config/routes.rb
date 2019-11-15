Rails.application.routes.draw do

  root to: 'event#index'
  post "/event/:event_id/participation", to: "participation#create", as: "new_participation"

  resources :event do
    resources :participation, only: [:index,:new,:create]
    resources :event_images, only: [:create]
  end

  resources :user , only: [:show, :edit, :update] do
    resources :profile_pictures, only: [:create]
  end


  namespace :admin do
    root to: 'admin#index'
    resources :users, :events
  end

  devise_for :users
  resources :charges
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
