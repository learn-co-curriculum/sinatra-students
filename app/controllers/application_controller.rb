# This is the main application controller. It is mounted as the Rack application
# in config.ru. The purpose of this class is to provide an inheritance point for
# the rest of our controllers.

# Do not code routes or controller actions within this class.

class ApplicationController < Sinatra::Base
  # A custom view path to support a more MVC structure.
  # This will point all views to app/views, leaving you to specify
  # the controller subfolder and the view when rendering erb.
  # See the example in students_controller.rb, get '/'.
  set :views, Proc.new { File.join(root, "../views") }
  
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
end