class Node
  attr_accessor :value, :next
  def initialize(name)
    @value = name
  end

  def last
    node = self
    while (node.next)
      node = node.next
    end
    node
  end

  def to_s
    list = [@value] 
    node = self
    while node.next
      node = node.next
      list << node.value
      unless list.uniq.length == list.length
        list.pop
        list << "#{node.value} (loop detected)"
        break
      end
    end
    return list.join(" -> ")
  end
end

####################################
#
## Tests
#
first = Node.new("Apple")
puts first.value == "Apple" ? "Success" : "Failure"
puts first.next == nil ? "Success" : "Failure"

second = Node.new("Banana")
first.next = second

third = Node.new("Cherry")
second.next = third

fourth = Node.new("Dragonfruit")
third.next = fourth

puts first.last == fourth ? "Success" : "Failure"
puts fourth.last == fourth ? "Success" : "Failure"

puts "#{first}" == "Apple -> Banana -> Cherry -> Dragonfruit" ? "Success" : "Failure"
puts "#{third}" == "Cherry -> Dragonfruit" ? "Success" : "Failure"

# extra credit uncomment when ready for this
fourth.next = first
puts "#{first}" == "Apple -> Banana -> Cherry -> Dragonfruit -> Apple (loop detected)" ? "Success" : "Failure"
