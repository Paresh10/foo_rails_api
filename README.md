# Ruby On Rails Api
This api provides the status on customer rewards points based on their purchasing history.

## Ruby version
* 2.7.2


## How to initialize the app
* Please clone this repo and cd into it.
* Run `bundle install` which will install all the dependencies being used in this app from Gemfile
* Run rake db:dreate which will create the database in your local development env
* Run rake db:migrate which will run the migration files
* Run rake db:seed which will seed the database from db/seeds.rb

## How to run rake tasks?
* To see the list of all the tasks please run `rake --tasks`
* For this specific api you should run `rake orders:sync_rewards` which will add the redards to each order based on given conditions


## How to run test
* There are test cases implemented for models and controller. To run the test please run this command `rspec spec` and like me if you like to see outout in a better logs please run `rspec spec -f d` 

## How to get the data from api
* Once you have the above steps taken care of, please start your rails server by executing `bin/rails s`.
* and now make a request to fetch the api to get customer reports to this url 'http://localhost:3000/customer/customers_report' assuming your rails server is running on `port 3000`
