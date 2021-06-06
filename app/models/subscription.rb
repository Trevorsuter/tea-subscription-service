class Subscription < ApplicationRecord
  validates :title, presence: true
  validates :price, presence: true
  validates :status, presence: true
  validates :frequency, presence: true

  has_many :customer_subscriptions
  has_many :subscription_teas
  has_many :customers, through: :customer_subscriptions
  has_many :teas, through: :subscription_teas

  enum status: [ 'active', 'cancelled' ]
end
