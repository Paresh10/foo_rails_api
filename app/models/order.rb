# = Schema Information
# Table name: orders

# id                :integer    not null, primary_key
# customer_id       :integer    not null, foreign_key
# amount            :bigint
# rewards           :integer

class Order < ApplicationRecord
    belongs_to :customers, optional: true

    def self.rewards_per_purchase
        reward_points = 0

        orders_between_12pm_and_1pm = Order.where("(created_at AT TIME ZONE 'UTC' AT TIME ZONE 'america/chicago')::time BETWEEN '12:00:00' AND '13:00:00'")
        if !orders_between_12pm_and_1pm.empty?
            orders_between_12pm_and_1pm.each do |ord|
                reward_points = (ord.amount / 3).ceil
                ord.update!(rewards: reward_points) if (reward_points > 2) && (reward_points <= 20)
            end        
        end

        orders_between_11am_and_12pm = Order.where("(created_at AT TIME ZONE 'UTC' AT TIME ZONE 'america/chicago')::time BETWEEN '11:00:00' AND '12:00:00'")

        if orders_between_11am_and_12pm.present?
            orders_between_11am_and_12pm.each do |ord|
                reward_points = (ord.amount / 2).ceil
                ord.update!(rewards: reward_points) if (reward_points > 2) && (reward_points <= 20)
            end
        end

        orders_between_1pm_and_2pm = Order.where("(created_at AT TIME ZONE 'UTC' AT TIME ZONE 'america/chicago')::time BETWEEN '13:00:00' AND '14:00:00'")

        if orders_between_1pm_and_2pm.present?
            orders_between_1pm_and_2pm.each do |ord|
                reward_points = (ord.amount / 2).ceil
                ord.update!(rewards: reward_points) if (reward_points > 2) && (reward_points <= 20)
            end
        end        

        orders_between_10am_and_11am = Order.where("(created_at AT TIME ZONE 'UTC' AT TIME ZONE 'america/chicago')::time BETWEEN '10:00:00' AND '11:00:00'")
        if orders_between_10am_and_11am.present?
            orders_between_10am_and_11am.each do |ord|
                reward_points = ord.amount.ceil
                ord.update!(rewards: reward_points) if (reward_points > 2) && (reward_points <= 20)
            end
        end

        orders_between_2pm_and_3pm = Order.where("(created_at AT TIME ZONE 'UTC' AT TIME ZONE 'america/chicago')::time BETWEEN '14:00:00' AND '15:00:00'")

        if orders_between_2pm_and_3pm.present?
            orders_between_2pm_and_3pm.each do |ord|
                reward_points += ord.amount.ceil
                ord.update!(rewards: reward_points) if (reward_points > 2) && (reward_points <= 20)
            end
        end   

        promotional_order_ids = orders_between_12pm_and_1pm.ids + orders_between_11am_and_12pm.ids + orders_between_1pm_and_2pm.ids + orders_between_10am_and_11am.ids + orders_between_2pm_and_3pm.ids

        regular_orders = Order.where(['id not in (?)', promotional_order_ids])

        if regular_orders.present?
            regular_orders.each do |ord|
                reward_points = (ord.amount * 0.25).ceil
                ord.update!(rewards: reward_points) if (reward_points > 2) && (reward_points <= 20)
            end            
        end      
    end
end
