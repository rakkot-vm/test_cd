# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/html/prod'

# Default branch is :master
set :branch, :"master"

# add user deployer
role :app, %w{ubuntu@ec2-3-15-224-63.us-east-2.compute.amazonaws.com}

namespace :deploy do
  after :updated, :updated do
    on roles(:all), in: :groups, limit: 3, wait: 10 do
       #execute "cd #{release_path} && php artisan migratez"
       #execute "cd #{release_path} && php artisan db:seed"
       execute "cd #{release_path} && composer dump-autoload"
       execute "cd #{release_path} && chmod -R 0777 storage"
       execute "cd #{release_path} && chmod -R 0777 bootstrap"
       execute "cd #{release_path} && chmod -R 0777 public/uploads"
       execute "cd #{release_path} && php artisan storage:link"
       execute "cd #{release_path} && php artisan cache:clear"
       execute "cd #{release_path} && php artisan view:clear"
       execute "service supervisor restart all"
       execute "cd #{release_path} && php artisan queue:restart"
    end
  end
end