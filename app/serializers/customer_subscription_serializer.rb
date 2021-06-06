class CustomerSubscriptionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :subscription, :customer
end
