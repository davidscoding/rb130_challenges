items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
  puts ""
end

gather(items) do |*first_produce, last|
  puts first_produce.join(", ")
  puts last
end

gather(items) do |first, *middle, last|
  puts first
  puts middle.join(", ")
  puts last
end

gather(items) do |first, *last|
  puts first
  puts last.join(", ")
end

gather(items) do |first, second, third, fourth|
  puts "#{first} #{second} #{third} #{fourth}"
end

# # Replace the two `method_name` placeholders with actual method calls
# def convert_to_base_8(n)
#   n.to_s(8).to_i
# end

# p base_8_string(64)

# # Replace `argument` with the correct argument below
# # `method` is `Object#method`, not a placeholder
# base8_proc = method(:convert_to_base_8).to_proc

# # We'll need a Proc object to make this code work
# # Replace `a_proc` with the correct object
# [8, 10, 12, 14, 16, 33].map(&base8_proc)

def bubble_sort!(array)
  loop do
    swapped = false

    1.upto(array.size - 1) do |index|
      skip = ( block_given? ? yield(array[index - 1], array[index]) : array[index - 1] <= array[index] )
      next if skip
      array[index - 1], array[index] = array[index], array[index - 1]
      swapped = true
    end

    break unless swapped
  end
end

array = [5, 3]
bubble_sort!(array)
p array == [3, 5]

array = [5, 3, 7]
bubble_sort!(array) { |first, second| first >= second }
p array == [7, 5, 3]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
p array == [1, 2, 4, 6, 7]

array = [6, 12, 27, 22, 14]
bubble_sort!(array) { |first, second| (first % 7) <= (second % 7) }
p array == [14, 22, 12, 6, 27]

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array)
p array == %w(Kim Pete Tyler alice bonnie rachel sue)

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array) { |first, second| first.downcase <= second.downcase }
p array == %w(alice bonnie Kim Pete rachel sue Tyler)

# Medium 2

# Here's what we need to set up our test class for Cash Register. First, we need to require all
# necessary libraries and files. "minitest/autorun" is first on the list, as this is the library
# that will give us access to certain parts of the minitest framework we need. We also need to require
# the class we want to test and any classes it depends on. In this case we want cashregister, but
# that class depends on collaboration with the Transaction class. We've put those two classes in their
# own separate files, so two relative requires are necessary to gain access to both classes. 

# Finally we have to set up the correct testing class. By minitest convention, we'll be naming this class
# "Class name we want to test"Test: here its CashRegisterTest. We also have ot make sure
# our class subclasses from Minitest::Test. This is imnportant, this would be a plain ruby class and not
# a test class if we didn't.



