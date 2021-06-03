Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/subscriptions/:subscription_id/customers', to: 'subscription_customers#create', as: 'subscription_customers'
    end
  end
end
