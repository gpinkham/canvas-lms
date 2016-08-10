# config valid only for current version of Capistrano
lock '3.5.0'
set :application, 'canvas'
set :repo_url, 'git@github.com:gpinkham/canvas-lms.git'
set :repository, 'git@github.com:gpinkham/canvas-lms.git'
set :scm, 'git'

# Default branch is :master
set :branch, ENV['BRANCH'] || "stable"

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/dwapp/canvas'
set :application, 'canvas'


# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml', 'config/secrets.yml'

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}


# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :ssh_options, { :forward_agent => true }

set :passenger_restart_with_touch, true