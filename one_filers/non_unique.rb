require "awesome_print"

def orig(a)
  a.inject({}){ |a, b| a[b] = a[b].to_i + 1; a}.reject{ |a, b| b == 1 }.keys
end

def non_unique(original)
  hashes_with_count = original.each_with_object({}) do |item, hash|
    hash[item] = hash[item].to_i + 1
  end
  non_unique_hash = hashes_with_count.reject do |_, b|
    b == 1
  end
  non_unique_hash.keys
end

a = [1, 2, 2, 2, 3, 3, 3, "A", "A", "A"]
expected = [2, 3, "A"]
ap orig(a) == expected
ap non_unique(a) == expected
