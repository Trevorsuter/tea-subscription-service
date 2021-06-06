Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/subscriptions/:subscription_id/customers', to: 'subscription_customers#create', as: 'subscription_customers'
      delete '/subscriptions/:subscription_id/customers/:customer_id', to: 'subscription_customers#destroy', as: 'subscription_customer'
    end
  end
end
