<div align=center>
  <h1>Tea Subscription Service</h1>
    <p>This backend application is designed to expose api endpoints for a subscription service frontend application. Our subscription service consists of <b><i>customers, subscriptions,</i></b> and <b><i>teas</i></b>. One can request to add, delete, and list subscriptions for a certain customer. <i>Note: All endpoints meet JSON API V1 specifications.</i></p>
</div>

***

## Table of Contents
[Prerequisites](#prerequisites)  
[Installation](#installation)  
[Schema Design](#schema-design)  
[Running the App](#running-the-app)  
[Endpoints](#endpoints)  
[Built With](#built-with)  
[Author](#author)
***
## Prerequisites
*To run this app, you will need:*
- Ruby 2.5.3
- Rails 5.2.6
- Rbenv 1.1.2
- Bundler 2.2.17
***
## Installation
1. *fork and clone this repository*
2. *In the root directory of the app, run the following commands:* 
    - `bundle install` *(install gem packages)*
    - `rails db:create` *(create the database)*
    - `rails db:migrate` *(migrate tables and columns to the DB)*

3. *To ensure the app is working correctly, run the tests by executing this command in your CLI:*  
`bundle exec rspec`
***
## Schema Design
![Screen Shot 2021-06-02 at 11 31 23 AM](https://user-images.githubusercontent.com/72848529/120528430-b0960880-c398-11eb-9f34-50504b57d89d.png)
***
## Running the App
- To run this app, execute `rails s` in your CLI
- There is no database seed file, so in order to create records in the DB, run `rails c` in your CLI and create as many records as you please.
***
## Endpoints
### Add Subscription For Customer
`POST /api/v1/customers/:customer_id/subscriptions`  
`body: {subscription_id: :subscription_id}`  
  
**Required Path Parameters:**
- `:customer_id` - Valid Customer ID
  
**Body Requirements:**
- `subscription_id` - Valid Subscription ID  
  
**Important Notes:**
- A 404 response with error messages will occur if:
  - *Customer ID or Subscription ID is invalid*
  - *Customer ID or Subscription ID is not given*  
  
`POST /api/v1/customers/15/subscriptions, body: {subscription_id: 45}`  

*response status: 201*
```JSON
{
  "data": {
    "id": "1",
    "type": "customer_subscription",
    "attributes": {
      "customer_id": "15",
      "subscription_id": "45"
    }
  }
}
``` 
***
### Delete Subscription for Customer
`DELETE /api/v1/customers/:customer_id/subscriptions/:subscription_id`  

**Required Path Parameters:**
- `:customer_id` - Valid Customer ID
- `subscription_id` - Valid Subscription ID  
  
**Important Notes:**
- A 404 response with error messages will occur if:
  - *Customer ID or Subscription ID is invalid*
  - *Customer ID or Subscription ID is not given*  

`DELETE '/api/v1/customers/15/subscriptions/45'`  

*response status: 200*
```JSON
{
  "data": {
    "id": "1",
    "type": "customer_subscription",
    "attributes": {
      "customer_id": "15",
      "subscription_id": "45"
    }
  }
}
```
***
### Customer Subscriptions Index
`GET '/api/v1/customers/:customer_id/subscriptions'`  

**Required Path Parameters:**
- `:customer_id` - Valid Customer ID
  
**Important Notes:**
- A 404 response with error messages will occur if:
  - *Customer ID is invalid*
  - *Customer ID is not given*  

`GET '/api/v1/customers/15/subscriptions'`  

*response status: 200*
```JSON
{
  "data": [
    {
      "id": "20",
      "type": "subscription",
      "attributes": {
        "title": "My Tea Subscription",
        "price": "20.99",
        "status": "active",
        "frequency": "14"
      }
    },
    {
      "id": "22",
      "type": "subscription",
      "attributes": {
        "title": "The Best Tea Subscription",
        "price": "14.99",
        "status": "cancelled",
        "frequency": "14"
      }
    }
  ]
}
```
***
## Built With
- Ruby
- Rails
- RSpec
- FactoryBot
- Faker