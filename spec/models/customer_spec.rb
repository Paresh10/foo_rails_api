# = Schema Information
# Table name: customers

# id                       :integer    not null, primary_key
# name                     :string
# total_points             :integer
# avg_points_per_order     :integer

require 'spec_helper'
require "rails_helper"

RSpec.describe Customer, type: :model do
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

    describe ".customer_total_points" do
        let(:subject) { described_class.customer_total_points(cust_one['id']) }
        let(:subject_two) { described_class.customer_total_points(cust_two['id']) }
        let(:subject_three) { described_class.customer_total_points(cust_three['id']) }
        
        it "update and returns the earned total points for customer" do
            # byebug
            expect(subject).to eq 22
            expect(subject_two).to eq 3
            expect(subject_three).to eq 0
        end
    end

    describe ".average_points" do
        let(:subject) { described_class.average_points(cust_one['id']) }
        let(:subject_two) { described_class.average_points(cust_two['id']) }
        let(:subject_three) { described_class.average_points(cust_three['id']) }
        
        it "update and returns the average points per order for customer" do
            # byebug
            expect(subject).to eq 11
            expect(subject_two).to eq 3
            expect(subject_three).to eq 0
        end
    end    
end