# README

This README provides a technical overview of the project, including the necessary steps to get the application up and running.

Here are the key aspects you need to know:

* Ruby version: This project uses Ruby 3.1.2. Make sure you have it installed on your system.

* System dependencies: The dependencies for this project are managed by Bundler. Run `bundle install` to install them.

* Configuration: All configuration is done in the `config` directory. Check the individual files for more details.

* Database creation: This project uses PostgreSQL. Run `rake db:create` to create the database.

* Database initialization: Run `rake db:migrate` to initialize the database.

* How to run the test suite: Tests are written using RSpec. Run `rspec` to execute the test suite.

* Services: This project uses Sidekiq for job queues, Redis for caching, and Elasticsearch for search functionality.

* Deployment instructions: Deployment is done using Capistrano. Check the `config/deploy.rb` file for more details.

* Additional Notes: For any other information, please refer to the specific documentation files or code comments.
