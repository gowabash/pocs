require "bundler"
Bundler.require

ap ARGV

ap "Gots me some args" if ARGV.length > 0
ap "arg1 is #{ARGV[0]}" if ARGV.length > 0
