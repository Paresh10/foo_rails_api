# Fooda Rails Api

## Ruby version
* 2.7.2


## How to run the app
* Please clone this repo and cd into it.
* Run `bundle install` which will install all the dependencies being used in this app from Gemfile
* Run rake db:dreate which will create the database in your local development env
* Run rake db:migrate which will run the migration files
* Run rake db:seed which will seed the database from db/seeds.rb

## What to expect?
* This api provides the status on customer rewards points based on their purchasing history.
* Use your console. You can run bin/raiils c or rails c to open the development env in console.
* Now we want to run through our code and and get the results.

* run `Order.rewards_per_purchase` this is the Order class method which will update customer rewards in Order model
* run `Customer.customer_total_points(customer_id)` this Customer class method takes an argument which is a `customer_id` and wll output the total points for provided customer
* run `Customer.average_points(customer_id)` this Customer class method also takes a `customer_id` as an argument and will return the avg points per order for given customer.
* run `Customer.customer_report` this Customer class method will output the report of each customer with Total points and avg points per order.

## How to run test
* There are test cases implemented for models and controller. To run the test please run this command `rspec spec` and like me if you like to see outout in a better logs please run `rspec spec -f d` 

## How to get the data from api
* Once you have the above steps taken care. Please start your rails server by executing `bin/rails s`.
* and now make a request to fetch the api to get customer reports to this url 'http://localhost:3000/customer/customers_report' assuming your rails server is running on port 3000
