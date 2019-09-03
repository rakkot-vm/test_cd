# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/html'

# Default branch is :dev
set :branch, :"dev"

# add user deployer
role :app, %w{ec2-user@ec2-18-191-211-175.us-east-2.compute.amazonaws.com}

namespace :deploy do
  after :updated, :updated do
    on roles(:all), in: :groups, limit: 3, wait: 10 do
       #execute "cd #{release_path} && composer update"
       execute "cd #{release_path} && php artisan migrate"
       execute "cd #{release_path} && php artisan optimize"
       execute "cd #{release_path} && composer dump-autoload"
       execute "cd #{release_path} && chmod -R 0777 storage"
       execute "cd #{release_path} && chmod -R 0777 bootstrap"
       execute "cd #{release_path} && chmod -R 0777 public/uploads"
       execute "cd #{release_path} && php artisan storage:link"
       execute "cd #{release_path} && php artisan cache:clear"
       execute "cd #{release_path} && php artisan view:clear"
       execute "cd #{release_path} && php artisan vendor:publish --tag=ckeditor"
       execute "service supervisor restart all"
       execute "cd #{release_path} && php artisan queue:restart"
       execute "cd #{release_path} && sudo npm install"
       execute "cd #{release_path} && sudo npm run production"
       #execute "cd #{release_path}/../.. && rm -R repo"
    end
  end
end