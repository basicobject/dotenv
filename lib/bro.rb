#!/usr/bin/env ruby

require 'thor'
require 'terminal-table'
require 'yaml'
require 'pry'

class Bro < Thor

  def self.config
    @config ||= YAML.load(File.read(File.expand_path("../../config.yml", __FILE__)))
  end

  no_commands do

    def print_line(msg)
      puts "\033[0;32m #{msg} \033[0m"
    end

    def print_error(msg)
      puts "\033[0;31m #{msg} \033[0m"
    end

    def run_secure_connect_command(type, server, user)
      ip = Bro.config['servers'][server]

      if ip.nil?
        print_error "#{server}: server not found in the list"
        exit(1)
      end

      command = "#{type} #{user}@#{ip}"

      begin
        print_line "Running: #{command} use Password: #{Bro.config['dev_password']} for dev"
        system(command)
      rescue => ex
        print_error ex.message
      end
    end
  end

  desc "list servers", "bro servers"
  def servers
    rows = Bro.config['servers'].to_a
    table = Terminal::Table.new(:title => "Server List", :headings => ['Name', 'IP'], :rows => rows)
    table.align_column(1, :right)
    puts table
  end

  desc "ssh to servers", "bro ssh <server_name>"
  def ssh(server, user='dev')
    run_secure_connect_command("ssh", server, user)
  end

  desc "sftp to servers", "bro sftp <server_name>"
  def sftp(server, user='dev')
    run_secure_connect_command("sftp", server, user)
  end

  desc "start service", "bro start <service_name>"
  def start(name)
    case name
    when 'server' then
      command = "ruby -run -e httpd -- -p 5000 ."
      print_line "Running #{command}"
      system(command)
    when 'mongodb' then
      command = "mongod --journal --fork --logpath=/dev/null"
      print_line "Starting mongodb server"
      print_line "Running #{command}"
      system(command)
    when 'redis'
      command = "redis-server ~/.env/conf/redis.conf"
      print_line "Starting redis server"
      print_line "Running #{command}"
      system(command)
    when 'vm', 'tm'
      command = "VBoxManage startvm turingmachine --type headless"
      print_line "Starting VirtualBox loading turingmachine"
      print_line "Running #{command}"
      system(command)
    else
      print_line "Teach me how to start #{name}, I will do it next time."
    end
  end

  desc "scan port", "bro scan <hostname> range"
  def scan(hostname, range=0)
    command = "nmap -n -sP #{hostname}/#{range}"
    system(command)
  end
end

Bro.start(ARGV)
