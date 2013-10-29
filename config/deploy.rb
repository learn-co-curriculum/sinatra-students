require 'bundler/capistrano' # for bundler support

set :application, "sinatra-students-ruby-003" # This should mirror what you put in your NGinx Conf

set :user, 'deploy' # Whatever the User You Make on Your Server

set :repository,  "git@github.com:flatiron-school/sinatra-students-ruby-003.git" # The address of your fork's clone URL

set :branch, "deployment-lecture"

set :deploy_to, "/home/#{ user }/#{ application }"
set :use_sudo, false

set :scm, :git

default_run_options[:pty] = true

set :server_ip, '162.243.77.86' # This should be your server IP
role :web, "#{server_ip}"                          # Your HTTP server, Apache/etc
role :app, "#{server_ip}"                          # This may be the same as your `Web` server
role :db,  "#{server_ip}", :primary => true        # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
before "deploy:restart", "deploy:symlink_database"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :symlink_database, :roles => :app do
    run "ln -nfs #{shared_path}/students-production.db #{current_path}/db/students-production.db"
  end

  task :migrate, :roles => :app do 
    run "cd #{current_path} && rake db:migrate RACK_ENV=production"
  end

  task :scrape_students, :roles => :app do
    run "cd #{current_path} && rake scrape_students RACK_ENV=production"
  end
 
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end