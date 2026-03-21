Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  match "/404", to: "application#not_found",    via: :all
  match "/422", to: "application#unprocessable", via: :all
  match "/500", to: "application#bad_request",   via: :all

  namespace :api do
    namespace :v1 do
      # Catch-all for unmatched API routes
      match "*path", to: "application#not_found", via: :all
    end
  end
end
