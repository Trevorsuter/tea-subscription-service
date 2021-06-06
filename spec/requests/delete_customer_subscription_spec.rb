require 'rails_helper'

RSpec.describe 'delete customer subscription' do
  describe 'happy path' do
    before :each do
      create_list :customer, 5
      create_list :subscription, 5
      @customer1 = Customer.first
      @customer2 = Customer.second
      @subscription1 = Subscription.first
      @subscription2 = Subscription.second
      
      @sub1 = CustomerSubscription.create(customer: @customer1, subscription: @subscription1)
      @sub2 = CustomerSubscription.create(customer: @customer2, subscription: @subscription2)

      delete api_v1_customer_subscription_path(@customer1, subscription_id: @subscription1.id)

      @result = JSON.parse(response.body, symbolize_names: true)
    end

    it 'has a successful response' do

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

    it 'will delete the subscription customer' do

      expect(CustomerSubscription.all).to_not include(@sub1)
    end

    it 'outputs the correct response' do

      expect(@result).to have_key(:data)

      expect(@result[:data]).to have_key(:id)
      expect(@result[:data][:id].to_i).to eq(@sub1.id)
      expect(@result[:data]).to have_key(:type)
      expect(@result[:data][:type]).to eq("customer_subscription")
      expect(@result[:data]).to have_key(:attributes)

      expect(@result[:data][:attributes]).to have_key(:customer)
      expect(@result[:data][:attributes]).to have_key(:subscription)
    end
  end

  describe 'sad path' do
    it 'will return 404 if no subscription customer is found' do
      delete api_v1_customer_subscription_path(0, subscription_id: 0)
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)
      expect(result[:message]).to eq("This record does not exist")
    end
  end
end