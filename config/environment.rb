
# This file will load our environment.

# It's goals are:
# 1. To load all gems via bundler.
# 2. To establish a database connection or Sequel to use.
# 3. To load all the files of our application, models, concerns, controllers

# Load Bundler
require 'bundler'  
Bundler.require(:default, ENV['RACK_ENV'])

# A little about ENV['RACK_ENV']
# ENV is a constant that is provided by ruby that stores Environmental
# variables in a hash. These variables cross the boundary of our application,
# to the system the application runs on. Thus, a command line argument
# or a BASH variable will be present in this object.

# Rack likes to store the mode our application should run within a variable
# called RACK_ENV with ENV. This allows our application to run in different
# modes with different settings and configurations.

# The two modes we are interested in are "development" and "test".

# Establish our Database connection.
DB = Sequel.connect("sqlite://db/students-#{ENV['RACK_ENV']}.db")
require_relative "../app/controllers/application_controller"
# Load our models, concerns, and controllers
def load_dirs(array)
  array.each do |dir|
    Dir.entries(dir).each do |file|
      next if file.start_with?(".")
      require_relative "../#{dir}/#{file}"
    end
  end
end

load_dirs(['app/concerns', 'app/models', 'app/controllers'])
