namespace :customers do
    desc "It adds total and avg points to each customer"
    task sync_points: :environment do
        Rails.logger.info("Adding total_points to customers: Started")
        
        Customer.find_each do |cust|
            # This will call the method from Customer class
            Customer.customer_total_points(cust['id'])
            Customer.average_points(cust['id'])
        end
        Rails.logger.info("Adding total_points to customers: Completed")
    end
end 