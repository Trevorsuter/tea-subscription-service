require 'rails_helper'

RSpec.describe 'create subscription customer' do
  describe 'happy path' do
    before :each do
      create_list :customer, 5
      create_list :subscription_tea, 5
      @customer1 = Customer.first
      @subscription1 = Subscription.first
      headers = {'CONTENT_TYPE' => 'application/json'}
      body = {customer_id: @customer1.id}.to_json

      post api_v1_subscription_customers_path(@subscription1), headers: headers, params: body
    end

    it 'has a successful creation response' do

      expect(response).to be_successful
      expect(response.status).to eq(201)
    end

  end
  describe 'sad path' do
  end
end