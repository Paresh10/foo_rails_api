require 'spec_helper'
require "rails_helper"

RSpec.describe CustomerController, type: :request do
    let(:cust_one) { Customer.create!(id: 1, name: "Jessica", created_at: "2020-07-01T00:00:00-05:00") }
    let(:cust_two) { Customer.create!(id: 2, name: "Will", created_at: "2020-07-01T01:00:00-05:00") }
    let(:cust_three) { Customer.create!(id:3, name: "Elizabeth", created_at: "2020-07-01T12:00:00-05:00") }
    let(:order_one) { Order.create!(id: 1, customer_id: cust_one['id'], amount: 12.50, created_at: "2020-07-01T12:15:57-05:00") }
    let(:order_two) { Order.create!(id: 2, customer_id: cust_one['id'], amount: 16.50, created_at: "2020-07-01T10:01:00-05:00") }
    let(:order_three) { Order.create!(id: 3, customer_id: cust_two['id'], amount: 8.90, created_at: "2020-07-01T12:20:00-05:00") }
    let(:order_four) { Order.create!(id: 4, customer_id: cust_two['id'], amount: 1.50, created_at: "2020-07-01T12:21:00-05:00") }


    before do
        cust_one
        cust_two
        cust_three
        order_one
        order_two
        order_three
        order_four
        Order.rewards_per_purchase
    end
    
    context "customers_report" do
        it "Generates customer reports and renders json" do
            get "/customer/customers_report"
            data = [
                {
                    "name": "Jessica",
                    "total_points": 22,
                    "avg_points": 11,
                    "msg": "Jessica: 22 points with 11 points per order."
                },
                {
                    "name": "Will",
                    "total_points": 3,
                    "avg_points": 3,
                    "msg": "Will: 3 points with 3 points per order."
                },
                {
                    "name": "Elizabeth",
                    "total_points": 0,
                    "avg_points": 0,
                    "msg": "Elizabeth: No Orders"
                }].to_json
            expect(response).to have_http_status(200)
            expect(JSON.parse(response.body.to_json)).to eq data
        end
    end
end