# config valid only for current version of Capistrano
lock "3.11.1"
#lock "3.9.1"

set :application, 'resume'
set :repo_url, 'https://github.com/rakkot-vm/test_cd'

# Set stage
set :stages, %w(production, dev)

# Set default stage
set :default_stage, "production"

# Default value for :scm is :git
set :git

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')
set :linked_files, fetch(:linked_files, []).push(
    '.env'
)

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push(
      'vendor',
      'storage/app',
      'public/uploads',
      'public/video'
)

# Default value for keep_releases is 5
set :keep_releases, 2
