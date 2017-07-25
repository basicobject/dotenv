# config valid only for current version of Capistrano
lock "3.8.2"

# set :application, "turingmachine"
# set :repo_url, "git@example.com:me/my_repo.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :rvm_ruby_version, '2.4.0'

set :package_list, %w(build-essential libmagickcore-dev imagemagick libmagickwand-dev libxml2-dev libxslt1-dev
                      git-core nginx redis-server curl nodejs htop)

# def create_deploy_user!
#   exit_status = capture 'id -u deploy &> /dev/null; echo $?'
#
#   if exit_status == '0'
#     info 'User deploy already exists'
#     return
#   end
#
#   info 'Creating deploy user'
#   execute('sudo useradd -m -g staff -s /bin/bash deploy')
#   # info 'Adding user deploy to sudoers'
#   # execute(%q(sudo su -c 'chmod +w /etc/sudoers'))
#   # execute(%q(sudo su -c 'echo "deploy ALL=(ALL) ALL" >> /etc/sudoers'))
#   # execute(%q(sudo su -c 'chmod -w /etc/sudoers'))
#   info 'User deploy is created and added to /etc/sudoers'
# end

# def install_rbenv!
#   exit_status = capture 'type rbenv &> /dev/null; echo $?'
#
#   if exit_status == '0'
#     'Rbenv already installed'
#   end
#
# end


# hack to avoid using space when passing the command string
# https://stackoverflow.com/questions/34307582/run-tasks-as-another-user
# SSHKit.config.command_map[:rbenv_copy_dir] = %q(cp -rf /tmp/rbenv /home/deploy/.rbenv)
# SSHKit.config.command_map[:rbenv_check_if_installed] = %q(type rbenv | head -n1)
# SSHKit.config.command_map[:rbenv_export_path] = %q(echo "export PATH=/home/deploy/.rbenv/bin:$PATH" >> /home/deploy/.bashrc)
# SSHKit.config.command_map[:rbenv_shell_init] = %q(echo eval "$(rbenv init -)" >> /home/deploy/.bashrc)

# desc 'install rbenv and ruby'
# task :install_rbenv_and_ruby do
#   on roles(:turingmachine) do |host|
#     # execute(%q(sudo apt-get install -y ruby-build)) # install using ruby-build
#
#     if capture(%q([ -d /tmp/rbenv/ ] && echo "Y" || echo "N")) == 'N'
#       execute(%q(git clone https://github.com/rbenv/rbenv.git /tmp/rbenv))
#     else
#       execute(%q(cd /tmp/rbenv && git pull origin master))
#     end
#
#     as 'deploy' do
#       within '/home/deploy' do
#         execute(:rbenv_copy_dir)
#
#         if capture(:rbenv_check_if_installed).strip != 'rbenv is a function'
#           # execute(:rbenv_export_path)
#           # execute(:rbenv_shell_init)
#           info '!!!!!!!! Please manually init the rbenv here, need to figgure out how to do this automatically'
#         else
#           info 'Rbenv is installed'
#         end
#       end
#     end
#   end
# end

desc 'Update system'
task :update_system do
  on roles(:turingmachine) do
    info 'Running system update'
    execute('sudo sudo apt-get update')
  end
end

desc 'Set system locale'
task :set_locale do
  on roles(:turingmachine) do
    info 'Setting locale'
    execute('export LC_ALL=C')
  end
end

desc 'Install packages'
task :install_packages do
  on roles(:turingmachine) do
    info 'Installing packages'
    execute("sudo apt-get -y install #{fetch(:package_list).join(' ')}")
  end
end

desc 'Create deploy user'
task :create_deploy_user do

  on roles(:turingmachine) do
    exit_status = capture 'id -u deploy &> /dev/null; echo $?'

    if exit_status == '0'
      info 'User deploy already exists'
      next
    end

    info 'Creating deploy user'
    execute('sudo useradd -m -g staff -s /bin/bash deploy')
    info 'User deploy created'
  end
end

desc 'Add deploy user to /etc/sudoers'
task :add_deploy_user_to_sudoers do
  on roles(:turingmachine) do
    info 'Adding user deploy to sudoers'
    execute(%q(sudo su -c 'chmod +w /etc/sudoers'))
    execute(%q(sudo su -c 'echo "deploy ALL=(ALL) ALL" >> /etc/sudoers'))
    execute(%q(sudo su -c 'chmod -w /etc/sudoers'))
    info 'User deploy is added to /etc/sudoers'
  end
end

desc 'Setup server'
task :setup_server do
  on roles(:turingmachine) do | host |
    info "Runing update on Host #{host} (#{host.roles.to_a.join(', ')}):\t#{capture(:uptime)}"
    invoke('update_system')
    invoke('set_locale')
    invoke('install_packages')
    invoke('create_deploy_user')
  end
end


desc 'Deployment'
task :deploy do
  info 'Deployment is disabled'
end
