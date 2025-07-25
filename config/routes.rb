Rails.application.routes.draw do
  resources :lessons
  devise_for :users

  resources :courses do
    resources :lessons
  end

  resources :checkouts , only: [:create]

  post "webhooks/stripe", to: "webhooks#stripe"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "courses#index"
end
