class SubscriptionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :price, :status, :frequency
  has_many :customers
  has_many :teas
end
