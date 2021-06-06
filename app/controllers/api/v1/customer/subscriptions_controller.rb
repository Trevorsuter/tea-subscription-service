class Api::V1::Customer::SubscriptionsController < ApplicationController

  def index
    @customer = Customer.find_by(id: params[:customer_id])
    if @customer.nil?
      render json: {message: "Customer doesn't exist", errors: ["Couldn't find Customer with 'id'=#{params[:customer_id]}"]}, status: 404
    else
      render json: SubscriptionSerializer.new(@customer.subscriptions)
    end
  end
end