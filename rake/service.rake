require 'pry'

namespace :mongodb do

  desc 'start mongodb server'
  task :start do
    puts 'Starting mongodb without logging'
    command = 'mongod --journal --fork --logpath=/dev/null'
    sh command
  end
end

namespace :redis do
  desc 'start redis-server'
  task :start do
    puts 'Starting redis server'
    command = 'redis-server ~/.env/conf/redis.conf'
  end
end
