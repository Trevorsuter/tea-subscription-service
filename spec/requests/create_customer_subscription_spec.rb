require 'rails_helper'

RSpec.describe 'create customer subscription' do
  describe 'happy path' do
    before :each do
      create_list :customer, 5
      create_list :subscription_tea, 5
      @customer1 = Customer.first
      @subscription1 = Subscription.first
      headers = {'CONTENT_TYPE' => 'application/json'}
      body = {subscription_id: @subscription1.id}.to_json
      
      post api_v1_customer_subscriptions_index_path(@customer1), headers: headers, params: body

      @result = JSON.parse(response.body, symbolize_names: true)
    end

    it 'has a successful creation response' do

      expect(response).to be_successful
      expect(response.status).to eq(201)
    end

    it 'creates a subscription customer' do
      subscription_customer = CustomerSubscription.find_by(customer: @customer1, subscription: @subscription1)
      
      expect(subscription_customer.customer).to eq(@customer1)
      expect(subscription_customer.subscription).to eq(@subscription1)
    end

    it 'has the correct output' do

      expect(@result).to have_key(:data)

      expect(@result[:data]).to have_key(:id)
      expect(@result[:data]).to have_key(:type)
      expect(@result[:data]).to have_key(:attributes)

      expect(@result[:data][:attributes]).to have_key(:customer)
      expect(@result[:data][:attributes]).to have_key(:subscription)
    end

  end
  describe 'sad path' do

    it 'returns 400 if no customer given' do
      create_list :customer, 5
      create_list :subscription_tea, 5
      headers = {'CONTENT_TYPE' => 'application/json'}
      @customer1 = Customer.first

      post api_v1_customer_subscriptions_path(@customer1), headers: headers

      expect(response.status).to eq(400)
    end

    it 'returns the error message if no customer given' do
      create_list :customer, 5
      create_list :subscription_tea, 5
      headers = {'CONTENT_TYPE' => 'application/json'}
      @customer1 = Customer.first

      post api_v1_customer_subscriptions_path(@customer1), headers: headers

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key(:errors)
      expect(result[:errors]).to include("Subscription must exist")
    end
  end
end