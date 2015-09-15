require 'awesome_print'

def palindrome(string)
  plain = string.downcase.gsub(/[^a-z]/, '').chars.to_a
  test = false
  total = plain.length - 1
  plain.each_index do |i|
    #ap i
    break if (total - 1) < i
    test ||= (plain[i] != plain[total - i]) 
    #puts plain[i].to_s + " _ " + plain[total - i].to_s  + " _ " + (plain[i] != plain[total - i]).to_s
  end
  !test
end

class Test
  def self.assert_equals(a, b)
    puts a==b
  end
end

Test.assert_equals(palindrome("Amore, Roma"), true)
Test.assert_equals(palindrome("A man, a plan, a canal: Panama"), true)
Test.assert_equals(palindrome("No 'x' in 'Nixon'"), true)
Test.assert_equals(palindrome("Abba Zabba, you're my only friend"), false)
Test.assert_equals(palindrome("no no no, not in my house"), false)
