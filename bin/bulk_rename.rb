#!/usr/bin/env ruby

# works only in the current directory
# copy files to be renamed to a directory and cd to that directory
# specify the pattern of filename and prefix
# run this file

if ARGV.size < 2
  puts "Usage ./bulk_rename.rb prefix filenames eg: ./bulk_rename.rb aa *.png"
  exit(1)
end

prefix      = ARGV.first
file_list   = ARGV.drop(1).sort
index       = 0
base_count  = 10
entry_count = file_list.size

base_count *= 10 while ((entry_count /= 10) != 0)

file_list.each do |entry|
  ext = File.extname(entry)
  File.rename(entry, "#{prefix}#{base_count + index}#{ext}")
  index += 1
end
