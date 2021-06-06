class Api::V1::SubscriptionCustomersController < ApplicationController

  def create
    @sc = SubscriptionCustomer.new(subscription_customer_params)
    if !@sc.save
      render json:{errors: @sc.errors.full_messages}, status: 400
    else
      render json: SubscriptionCustomerSerializer.new(@sc), status: 201
    end
  end

  def destroy
    @sc = SubscriptionCustomer.find_by(customer_id: params[:customer_id], subscription_id: params[:subscription_id])
    if @sc.nil?
      render json: {message: "This record does not exist", errors: []}
    else
      @sc.destroy
      render json: SubscriptionCustomerSerializer.new(@sc), status: 200
    end
  end

  private

  def subscription_customer_params
    params.permit(:customer_id, :subscription_id)
  end
end