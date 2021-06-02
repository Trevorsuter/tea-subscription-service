class Tea < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :brew_time, presence: true
  validates :temperature, presence: true

  has_many :subscription_teas
  has_many :subscriptions, through: :subscription_teas
end
