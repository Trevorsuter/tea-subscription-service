class SubscriptionCustomerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :subscription, :customer
end
