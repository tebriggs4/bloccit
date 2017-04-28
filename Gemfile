source 'https://rubygems.org'
 
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
 
# We specify different databases for our Development and Production environments.
# We use sqlite3 for our Development environment because it is an easy to use database
# perfect for rapid testing. Heroku only supports Postgres, so we use pg in our Production environment.
group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :development do
  gem 'sqlite3'
end

# We added rspec-rails to the :development and :test groups because we want its tasks and generators
# to be available in both environments. We specified a version (~> 3.0) to maintain predictable behavior despite new RSpec releases.
group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda'
  gem 'factory_girl_rails', '~> 4.0'    # To build user objects
end
 
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Bootstrap
gem 'bootstrap-sass'
# Used for encrypting User passwords
gem 'bcrypt'
gem 'figaro', '1.0'