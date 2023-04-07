set :default_exec_env, { 'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH" }
set :bundle_flags, "--quiet"
set :rake, 'bundle exec rake'

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "chmod +x #{release_path}/bin/rails"
      execute "sudo service nginx restart"
    end
  end
end
