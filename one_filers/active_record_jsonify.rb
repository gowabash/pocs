users1 = User.select(:id, :name).to_a
puts "user count  - #{users1.count}"

time3 = Benchmark.measure do
  users2 = User.all.pluck_to_hash_array(:id, :name)
end
time = Benchmark.measure do
  users = User.select(:id, :name).to_a
  users.map { |u| {id: u.id, name: u.name}}
end
time2 = Benchmark.measure do
  users = User.select(:id, :name).to_a
  users.map { |user| user.serializable_hash.symbolize_keys }
end



puts "Direct Hash - #{time.real}"
puts "Serialize   - #{time2.real}"
puts "pluck       - #{time3.real}"
