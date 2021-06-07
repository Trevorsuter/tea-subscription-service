class CustomerSubscriptionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :subscription_id, :customer_id
end
