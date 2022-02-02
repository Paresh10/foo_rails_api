namespace :orders do
    desc "It adds the redards to each order based on given conditions"
    task sync_rewards: :environment do
        Rails.logger.info("Adding rewards to orders: Started")
        
        # This will call the method from order class
        Order.rewards_per_purchase

        Rails.logger.info("Adding rewards to orders: Completed")
    end
end 