require "awesome_print"
MAX = 100
i = 0
foo = Enumerator.new do |y|
  loop do
    y << i
    i += 1
    #reset the counter to use again
    if i == MAX
      i = 0
      break
    end
  end
end

foo.each do |a|
  ap "a is #{a}"
end

ap foo.class
ap "count #{foo.count}"
ap "size #{foo.size}"
foo.first
foo.each do |a|
  ap "a is #{a}"
end
ap "count #{foo.count}"
