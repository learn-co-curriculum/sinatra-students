# When running tests, we want to make sure that RACK_ENV is set to test.
ENV['RACK_ENV'] = 'test'

# We load our Rakefile so that when running the tests, we create a new
# version of our test database everytime.
require 'rake'
load './Rakefile'

# We load the Rack/Test helpers.
require 'rack/test'

# Configure simplecov to provide code coverage ignoring things
# that do not need to be tested.
require 'simplecov'
SimpleCov.start do 
  add_filter '/app/controllers/application_controller.rb'
  add_filter '/db/'    
  add_filter '/config/'
  add_filter '/spec/'
  add_filter '/public/'
  add_filter '/lib/' # Feel free to write coverage for the StudentScrape
end

# Load our environment.
require_relative '../config/environment'

# Do some sinatra configurations that I'm actually not 100% sure what they
# do our how they work but I see these in a bunch of Sinatra test suites.
# I doubt we really need this but why not?
# set :environment, :test
# set :run, false
# set :raise_errors, true
# set :logging, false

# Configure rspec.
RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include FactoryGirl::Syntax::Methods
  FactoryGirl.find_definitions
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
  
  # Add a global before to reset the database on every execution
  # of the test suite.
  config.before(:all) do
    Rake::Task['db:reset'].invoke()
  end

  config.before(:each) do
    DB.tables.each do |table|
      DB.run("DELETE FROM #{table}")
    end
  end
end

# This is something we need to do to test our Rack/Sinatra controllers.
# last_response works via triggering an instance of the application under test
# The assumption Rack/Test makes is that you create a `app` method/variable
# that represents the application you want to be testing.

# We alias app to be the subject of our tests so that in controller specs,
# if we describe StudentsController, subject will be an instance of that
# which app will use to trigger requests/responses.
def app
  subject
end
