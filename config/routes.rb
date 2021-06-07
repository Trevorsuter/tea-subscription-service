Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/customers/:customer_id/subscriptions', to: 'subscription_customers#create', as: 'customer_subscriptions'
      delete '/customers/:customer_id/subscriptions/:subscription_id', to: 'subscription_customers#destroy', as: 'customer_subscription'
      get '/customers/:customer_id/subscriptions', to: 'customers/subscriptions#index', as: 'customer_subscriptions_index'
    end
  end
end
