require 'pry'

namespace :mongodb do

  desc 'start mongodb server'
  task :start do
    puts 'Starting mongodb without logging'
    command = 'mongod --journal --fork --logpath=/dev/null'
    sh command
  end
end
