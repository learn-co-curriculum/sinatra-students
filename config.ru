require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use Rack::Static, :root => 'public', :urls => ['/images', '/css']


use StudentsController
# Mount the main controller as our Rack Application.
run ApplicationController
