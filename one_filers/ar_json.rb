users = User.select(:id, :name).to_a
time = Benchmark.measure do
  users.map { |u| {id: u.id, name: u.name}}
end
time2 = Benchmark.measure do
  users.map { |user| user.serializable_hash.symbolize_keys }
end

puts "Total users - #{users.count}"
puts "Direct Hash - #{time.real}"
puts "Serialize   - #{time2.real}"

