# = Schema Information
# Table name: orders

# id                :integer    not null, primary_key
# customer_id       :integer    not null, foreign_key
# amount            :bigint
# rewards           :integer

require 'spec_helper'
require "rails_helper"

RSpec.describe Order, type: :model do
    
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
    end
    describe ".rewards_per_purchase" do
        
        context "when customer places an order between 12pm to 1pm" do
            it "Customer gets 1 point per $3 spent" do
                
                orders_between_12pm_and_1pm = Order.where("(created_at AT TIME ZONE 'UTC' AT TIME ZONE 'america/chicago')::time BETWEEN '12:00:00' AND '13:00:00'")
                orders_between_12pm_and_1pm.each do |ord|
                    reward_points = (ord.amount / 3).ceil
                    ord.update!(rewards: reward_points) if (reward_points > 2) && (reward_points <= 20)
                end
                expect(Order.first['rewards']).to eq 5

            end
        end

        context "when customer places an order between 11am to 12pm" do
            it "Customer gets 1 point per $2 spent" do
                
                orders_between_11am_and_12pm = Order.where("(created_at AT TIME ZONE 'UTC' AT TIME ZONE 'america/chicago')::time BETWEEN '11:00:00' AND '12:00:00'")
                expect(orders_between_11am_and_12pm).to eq []
                
            end
        end
        
        context "when customer places an order between 1pm to 2pm" do
            it "Customer gets 1 point per $2 spent" do
                
                orders_between_1pm_and_2pm = Order.where("(created_at AT TIME ZONE 'UTC' AT TIME ZONE 'america/chicago')::time BETWEEN '13:00:00' AND '14:00:00'")
                expect(orders_between_1pm_and_2pm).to eq []
                
            end
        end

        context "when customer places an order between 10am to 11am" do
            it "Customer gets 1 point per $1 spent" do
                
                orders_between_10am_and_11am = Order.where("(created_at AT TIME ZONE 'UTC' AT TIME ZONE 'america/chicago')::time BETWEEN '10:00:00' AND '11:00:00'")
                orders_between_10am_and_11am.each do |ord|
                    reward_points = ord.amount.ceil
                    ord.update!(rewards: reward_points) if (reward_points > 2) && (reward_points <= 20)
                end
                order = Order.find_by_id(2)
                expect(order['rewards']).to eq 17
                
            end
        end

        context "when customer places an order between 2pm to 3pm" do
            it "Customer gets 1 point per $1 spent" do
                
                orders_between_2pm_and_3pm = Order.where("(created_at AT TIME ZONE 'UTC' AT TIME ZONE 'america/chicago')::time BETWEEN '14:00:00' AND '15:00:00'")
                expect(orders_between_2pm_and_3pm).to eq []
                
            end
        end

        context "when customer places an order any other time" do
            it "Customer gets 0.25 point per $1 spent" do
                
                promotional_order_ids = [1, 2]
                regular_orders = Order.where(['id not in (?)', promotional_order_ids])
                regular_orders.each do |ord|
                    reward_points = (ord.amount * 0.25).ceil
                    ord.update!(rewards: reward_points) if (reward_points > 2) && (reward_points <= 20)
                end
                
                order = Order.find_by_id(3)
                expect(order['rewards']).to eq 3
            end
        end
    end
end