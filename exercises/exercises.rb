# # 1
# class Tree
#   include Enumerable

#   def each
#   end

# end

# # # 2

# def compute(arg)
#   return yield(arg) if block_given?
#   "Does not compute." 
# end

# p compute { 5 + 3 } == 8
# p compute { 'a' + 'b' } == 'ab'
# p compute == 'Does not compute.'

# 3

# def missing(arr)
#   full = (arr.min..arr.max).to_a
#   full.reject{|val| arr.include?(val)}
# end

# p missing([-3, -2, 1, 5]) == [-1, 0, 2, 3, 4]
# p missing([1, 2, 3, 4]) == []
# p missing([1, 5]) == [2, 3, 4]
# p missing([6]) == []

# # 4

# def divisors(val)
#   root = (val**(0.5)).floor + 1 
#   divisor_list = []
#   (1..root).each do |divisor|
#     if val % divisor == 0
#       divisor_list << val / divisor
#       divisor_list << divisor
#     end
#   end
#   divisor_list.sort.uniq
# end

# p divisors(627)

# p divisors(1) == [1]
# p divisors(7) == [1, 7]
# p divisors(12) == [1, 2, 3, 4, 6, 12]
# p divisors(98) == [1, 2, 7, 14, 49, 98]
# p divisors(99400891) == [1, 9967, 9973, 99400891] # may take a minute

# # 5

# require "pry"
# require "pry-byebug"

# UPPER = ('A'..'Z').to_a
# LOWER = ('a'..'z').to_a

# def character(letter)
#   return letter unless UPPER.include?(letter.upcase)

#   arr = UPPER.include?(letter) ? UPPER : LOWER
# # binding.pry
#   if (arr.index(letter)) == nil
#     binding.pry
#   end
#   arr[(arr.index(letter) + 13) % 26]
# end

# def decipher_name(name)
#   name.chars.map { |char| character(char) }.join
# end
# # binding.pry

# names = YAML.load_file('secret_names.yml').split

# puts names.map { |name| decipher_name(name)}

# 6

# def any?(arr)
#   return false if arr.empty? || !block_given?
  
#   index = 0
#   while index < arr.length
#     return true if yield(arr[index])
#     index += 1
#   end

#   false
# end


# p any?([1, 3, 5, 6]) { |value| value.even? } == true
# p any?([1, 3, 5, 7]) { |value| value.even? } == false
# p any?([2, 4, 6, 8]) { |value| value.odd? } == false
# p any?([1, 3, 5, 7]) { |value| value % 5 == 0 } == true
# p any?([1, 3, 5, 7]) { |value| true } == true
# p any?([1, 3, 5, 7]) { |value| false } == false
# p any?([]) { |value| true } == false

# # 7

# def all?(collection)
#   collection.each {|val| return false unless yield(val)}
#   true
# end

# p all?([1, 3, 5, 6]) { |value| value.odd? } == false
# p all?([1, 3, 5, 7]) { |value| value.odd? } == true
# p all?([2, 4, 6, 8]) { |value| value.even? } == true
# p all?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
# p all?([1, 3, 5, 7]) { |value| true } == true
# p all?([1, 3, 5, 7]) { |value| false } == false
# p all?([]) { |value| false } == true

# # 8

# def none?(collection)
#   collection.each {|item| return false if yield(item)}
#   true
# end


# p none?([1, 3, 5, 6]) { |value| value.even? } == false
# p none?([1, 3, 5, 7]) { |value| value.even? } == true
# p none?([2, 4, 6, 8]) { |value| value.odd? } == true
# p none?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
# p none?([1, 3, 5, 7]) { |value| true } == false
# p none?([1, 3, 5, 7]) { |value| false } == true
# p none?([]) { |value| true } == true

# # 9

# def one?(collection)
#   bool = false

#   collection.each do |item| 
#     if yield(item)
#       return false if bool
#       bool = true
#     end
#   end

#   bool
# end


# p one?([1, 3, 5, 6]) { |value| value.even? }    # -> true
# p one?([1, 3, 5, 7]) { |value| value.odd? }     # -> false
# p one?([2, 4, 6, 8]) { |value| value.even? }    # -> false
# p one?([1, 3, 5, 7]) { |value| value % 5 == 0 } # -> true
# p one?([1, 3, 5, 7]) { |value| true }           # -> false
# p one?([1, 3, 5, 7]) { |value| false }          # -> false
# p one?([]) { |value| true }                     # -> false

# 10

# def count(collection)
#   count = 0
#   collection.each { |item| count += 1 if yield item}
#   count
# end

# p count([1,2,3,4,5]) { |value| value.odd? } == 3
# p count([1,2,3,4,5]) { |value| value % 3 == 1 } == 2
# p count([1,2,3,4,5]) { |value| true } == 5
# p count([1,2,3,4,5]) { |value| false } == 0
# p count([]) { |value| value.even? } == 0
# p count(%w(Four score and seven)) { |value| value.size == 5 } == 2

# 1

# def step(start, target, jump)
#   val = start
#   arr = []

#   while val <= target
#     yield val
#     arr << val
#     val += jump
#   end

#   arr[-1]
# end

# step(1, 10, 3) { |value| puts "value = #{value}" }

# value = 1
# value = 4
# value = 7
# value = 10

# # 2

# def zip(arr1, arr2)
#   arr1.map.with_index { |val, dex| [val, arr2[dex]]}
# end

# p zip([1, 2, 3], [4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]

# # 3

# def map(arr)
#   new_arr = []
#   arr.each { |val| new_arr << yield(val)}
#   new_arr
# end

# p map([1, 3, 6]) { |value| value**2 } == [1, 9, 36]
# p map([]) { |value| true } == []
# p map(['a', 'b', 'c', 'd']) { |value| false } == [false, false, false, false]
# p map(['a', 'b', 'c', 'd']) { |value| value.upcase } == ['A', 'B', 'C', 'D']
# p map([1, 3, 4]) { |value| (1..value).to_a } == [[1], [1, 2, 3], [1, 2, 3, 4]]

# 4

# def count(*arg)
#   total = 0
#   arg.each {|item| total += 1 if yield(item)}
#   total
# end

# 5

# def drop_while(arr)
#   drop_dex = 0

#   arr.each_with_index do |item, dex| 
#     break unless yield(item)
#     drop_dex = dex + 1
#   end

#   arr[drop_dex...arr.length]
# end

# p drop_while([1, 3, 5, 6]) { |value| value.odd? } == [6]
# p drop_while([1, 3, 5, 6]) { |value| value.even? } == [1, 3, 5, 6]
# p drop_while([1, 3, 5, 6]) { |value| true } == []
# p drop_while([1, 3, 5, 6]) { |value| false } == [1, 3, 5, 6]
# p drop_while([1, 3, 5, 6]) { |value| value < 5 } == [5, 6]
# p drop_while([]) { |value| true } == []

# 6

# def each_with_index(arr)
#   index = 0
#   while index < arr.length do
#     yield [arr[index], index]
#     index += 1
#   end
#   arr
# end

# result = (each_with_index([1, 3, 6]) do |value, index|
#   puts "#{index} -> #{value**index}"
# end)

# puts (result == [1, 3, 6])

# # 7

require 'pry'
require 'pry-byebug'

# def each_with_object(arr, obj)
#   arr.each { |item| yield ( [item, obj] ) }
#   obj
# end

# result = each_with_object([1, 3, 5], []) do |value, list|
#   list << value**2
# end
# p result == [1, 9, 25]

# result = each_with_object([1, 3, 5], []) do |value, list|
#   list << (1..value).to_a
# end
# p result == [[1], [1, 2, 3], [1, 2, 3, 4, 5]]

# result = each_with_object([1, 3, 5], {}) do |value, hash|
#   hash[value] = value**2
# end
# p result == { 1 => 1, 3 => 9, 5 => 25 }

# result = each_with_object([], {}) do |value, hash|
#   hash[value] = value * 2
# end
# p result == {}

# # 8

# def max_by(arr)
#   max = arr[0]
#   arr.each { |item| max = item if yield(item) > yield(max) }
#   max
# end

# p max_by([1, 5, 3]) { |value| value + 2 } == 5
# p max_by([1, 5, 3]) { |value| 9 - value } == 1
# p max_by([1, 5, 3]) { |value| (96 - value).chr } == 1
# p max_by([[1, 2], [3, 4, 5], [6]]) { |value| value.size } == [3, 4, 5]
# p max_by([-7]) { |value| value * 3 } == -7
# p max_by([]) { |value| value + 5 } == nil

# # 9

# def each_cons(arr)
#   (0..arr.length - 2).each do |index| 
#     yield(arr[index], arr[index + 1])
#   end
#   nil
# end

# hash = {}
# result = each_cons([1, 3, 6, 10]) do |value1, value2|
#   hash[value1] = value2
# end
# p result == nil
# p hash == { 1 => 3, 3 => 6, 6 => 10 }

# hash = {}
# result = each_cons([]) do |value1, value2|
#   hash[value1] = value2
# end
# p hash == {}
# p result == nil

# hash = {}
# result = each_cons(['a', 'b']) do |value1, value2|
#   hash[value1] = value2
# end
# p hash == {'a' => 'b'}
# p result == nil

# 10

# def each_cons(arr, n)
#   start_index = 0
#   end_index = n - 1
#   while end_index < arr.length
#     yield(*arr[start_index..end_index])
#     start_index += 1
#     end_index += 1
#   end
#   nil
# end

# hash = {}
# each_cons([1, 3, 6, 10], 1) do |value|
#   hash[value] = true
# end
# p hash == { 1 => true, 3 => true, 6 => true, 10 => true }

# hash = {}
# each_cons([1, 3, 6, 10], 2) do |value1, value2|
#   hash[value1] = value2
# end
# p hash == { 1 => 3, 3 => 6, 6 => 10 }

# hash = {}
# each_cons([1, 3, 6, 10], 3) do |value1, *values|
#   hash[value1] = values
# end
# p hash == { 1 => [3, 6], 3 => [6, 10] }

# hash = {}
# each_cons([1, 3, 6, 10], 4) do |value1, *values|
#   hash[value1] = values
# end
# p hash == { 1 => [3, 6, 10] }

# hash = {}
# each_cons([1, 3, 6, 10], 5) do |value1, *values|
#   hash[value1] = values
# end
# p hash == {}

# 1

