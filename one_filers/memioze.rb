#! /usr/bin/env ruby

def set_a_val
  puts "Called func"
  42
end

foo = nil

puts foo ||= set_a_val
puts foo ||= set_a_val
puts foo ||= set_a_val
