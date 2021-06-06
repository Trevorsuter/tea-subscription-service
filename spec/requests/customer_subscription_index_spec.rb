require 'rails_helper'

RSpec.describe 'customer subscription index' do
  describe 'happy path' do
    before :each do
      # initial factory creation
      @customer1 = create :customer
      @customer2 = create :customer
      @sub_list_1 = create_list :subscription_tea, 5
      @sub_list_2 = create_list :subscription_tea, 5

      # change first subscription to equal 'cancelled':
      first_sub = @sub_list_1.first.subscription
      first_sub.update_attribute(:status, 1)

      # create customer subscriptions for both customers
      @sub_list_1.each do |sub_tea|
        CustomerSubscription.create(customer: @customer1, subscription: sub_tea.subscription)
      end
      @sub_list_2.each do |sub_tea|
        CustomerSubscription.create(customer: @customer2, subscription: sub_tea.subscription)
      end

      # request
      get api_v1_customer_subscriptions_path(@customer1)

      # response
      @result = JSON.parse(response.body, symbolize_names: true)
    end
    it 'has a successful response' do

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

    it 'will output the right data' do

      expect(@result).to have_key(:data)

      @result[:data].each do |data|
        expect(data).to have_key(:id)
        expect(data).to have_key(:type)
        expect(data[:type]).to eq("subscription")
        expect(data).to have_key(:attributes)

        expect(data[:attributes]).to have_key(:title)
        expect(data[:attributes]).to have_key(:price)
        expect(data[:attributes]).to have_key(:status)
        expect(data[:attributes]).to have_key(:frequency)
      end
    end

    it 'wont output subscriptions from other users' do
      customer_2_subscription_ids = @customer2.subscriptions.pluck(:id)

      @result[:data].each do |data|
        expect(customer_2_subscription_ids).to_not include(data[:id])
      end
    end

    it 'will show the relationships for each subscription' do

      @result[:data].each do |data|
        expect(data).to have_key(:relationships)
        expect(data[:relationships]).to have_key(:customers)
        expect(data[:relationships]).to have_key(:teas)
      end
    end

    it 'will output subscriptions even if they are cancelled' do

      statuses = @result[:data].map do |data|
        data[:attributes][:status]
      end

      expect(statuses).to include("cancelled")
    end
  end

  describe 'sad path' do

    it 'will return 404 if customer does not exist' do
      get api_v1_customer_subscriptions_path(0)
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      expect(result[:message]).to eq("Customer doesn't exist")
      expect(result[:errors]).to include("Couldn't find Customer with 'id'=0")
    end
  end
end