require 'pry'
require 'pry-byebug'

# require 'simplecov'
# SimpleCov.start

# require 'minitest/autorun'
# require 'minitest/reporters'
# MiniTest::Reporters.use!

# class NewTest < MiniTest::Test
#   def test_odd?
#     assert(value.odd?), 'value is not odd'
#   end
# end

# # #assert tests whether its first argument is truthy. If the first argument it
# # not truthy, the test fails and the second argument is displayed as the failure message.

# # Most (but not all) of the minitest assertions let you specify a failure message as the
# # final argument. This is frequently ommitted since the error messages provided
# # by default are usually sufficient. However, the defualt message for assert lacks
# # context, so it is common to specify the failure message when using assert.

# # assert isn't used directly in most tests since it is usually more important to ensure an
# # exact value is returned; if you want to know that your method returns true and not just a
# # truthy value, assert_equal is a better choice.

# def test_downcase
#   assert_equal('xyz', value.downcase)
# end

# # #assert_equal tests whether its first two arguments are equal using #==. Failure messages
# # issued by #assert_equal assume that the first argument represents the expected
# # value, while the second argument represents the actual value to be tested

# def test_nil
#   assert_nil(value), "#{value} is not nil"
# end

# def test_array_empty
#   assert_empty(list)
# end

# #assert empty tests whether its first argument responds to the method empty? With a true
# # value. you can use: 

# assert_equal true, list.empty?

# # instead, but #assert_empty is clearer and issues a better failure message

# assert_raises(NoExperienceError) {employee.hire}

# assert_instance_of Numeric, value

# #assert_instance_of uses Object#instance_of? to ensure that its second argument is an isntance
# # of the class named as its second argument

# assert_kind_of Numeric, value

# #assert_kind_of uses Object#kind_of? to check if the class of its second argument is an
# # instance of the named class or one of the named class's subclasses.

# assert_same list, list.process

# refute_includes list, 'xyz' 

# # Medium 1

class Device
  def initialize
    @recordings = []
  end

  def listen
    record(yield) if block_given?
  end

  def play
    puts @recordings[-1]
  end

  def record(recording)
    @recordings << recording
  end
end

listener = Device.new
listener.listen { "Hello World!" }
listener.listen
listener.play # Outputs "Hello World!"

# We can see what needs to be implemented if we compare the code from the last code block
# of the description with the code given for our Device class. It seems we a missing Device#listen
# and a Device#play method. In our solution, we implement the Device#listen method by yielding
# to a block and then we record what was in that block if necessary.

# Notes that we include the block_given? to check for a block when blocks are
# optional. 

# 2

class TextAnalyzer
  def process
    file = File.open('sample_text.txt', 'r')
    yield(file.read)
    file.close
  end
end

analyzer = TextAnalyzer.new
analyzer.process { |text| puts "#{text.split("\n\n").count} paragraphs" }
analyzer.process { |text| puts "#{text.split("\n").count} lines" }
analyzer.process { |text| puts "#{text.split(" ").count} words"}

# For this exercise, you must fill in the missing parts of the code we gave you.
# You know the output we want; you must somehow produce that output.

# Start with the #process method; we told you that the #process should read
# some text from a file and then pass that text to the block for further processing.
# The usual approach for such read and process code looks like this:

file = File.open('sample_text.txt', 'r')
#processing
file.close

# Remember to always close files when you finish using them

# Since we're supposed to pass the text content of the file to the block, we must load the
# file's content and call the block, which we do with yield(file.read) :

file = File.open('sample_text.txt', 'r')
yield(file.read)
file.close

# At this point we have what we "sandwich code"; it performs some pre- and post-processing for some
# arbitrary action. Here, the pre-processing opens a file, and the post-processing closes it. Together,
# they sandwich the action that loads the files contents and passes it to a block.

# Since we're we're passing text to the blocks, the blocks should capture text:

# analyzer.process { |text| puts ... }
# analyzer.process { |text| puts ... }
# analyzer.process { |text| puts ... }

# Judging from the partial code, you can see that each block contains a puts statement, so we must
# provide arguments to puts that perform the necessary processing and format the answer accordingly.

# The last step fills in these details: for each we use String #split and Array#count.

# Before:

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  puts "#{items.join(', ')}"
  puts "Nice selection of food we have gathered!"
end

# After:

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "Nice selection of food we have gathered!"
end

gather(items){|items| puts "#{items.join(', ')}"}

# To accomplish our task, we need to yield the items array to a block. Mmoving implementation of our items
# formatting to a block gives the user more flexibility and choice for how they wish to use gather. By yielding items
# to a block, the user can join those items for presentation purposes or they can
# choose a completely idfferent respresentation. For example:

gather(items) do |produce|
  puts "We've gathered some vegetables: #{produce[1]} and #{produce[2]}"
end

# Ruby gives us a lot of flexibility when assigning arrays to variables. If we want to assign the entire array to a single
# variable, we can do that.

birds = %w(raven finch hawk eagle)

# If we want to assign every element to a separate variable, we can do that too:

# raven, finch, hawk, eagle = %w(raven finch hawk eagle)

# Suppose we want to organize our array contents into groups, where variables represent category names. Can we do that without
# extracting items directly from the array based on their indices?

# We can use the splat operator * to do something like this:

raven, finch, *raptors = %w(raven finch hawk eagle)
p raven #=> 'raven'
p finch #=> 'finch'
p raptors #=> ['hawk','eagle']

# Write a method that takes an array as an argument. The method should yield the contents of the array
# to a block, which should assign your block variables in such a way that it ignores the first two
# elements and groups all remaining elements as a raptors array.

def array_grouper(arr)
  yield(arr)
end

array_grouper{|_, _, *raptors| p raptors}

# For our solution, we start with an array named birds. It contains four birds, where two of them are raptors.
# Above we use our block variables to organize it further. When we yield birds to the block, Ruby assigns the
# individual elements of birds to the different block variables. It assigns the first two birds, "crow" and "finch"
# to _; the underscore tells Ruby that we aren't interested in those values. The splat operator on the name block variable
# tells Ruby to treat it as an Array and assign all remaining arguments to it. Here, we group the last two elements
# from birds into the array, raptors.

# For demonstration purposes, we join the two array elements and output them to the screen as:

Raptors: hawk, eagle

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end

gather(items) do |*first_produce, last|
  puts first_produce.join(", ")
  puts last
end

# This isn't necessarily just an exercise related to block, but how Ruby handles passing parameters in different situations. We can make
# equivalent code that gives us the same output, if we make changes to our gather method for each numbered problem.

# The calls for outputting our variables are the same, we can even move the block paramters and make them our method
# parameters. For calling this new gather method, we have to use *items instead of just items as an argument. For calling this new gather method,
# we have to use *items instead of just items as an argument. Using *items passes each array element as a list of items instead of a bundled array
# of items. Having to define four different methods though is cumbersome, using a block gives us much more flexibility on how we
# want to group our output.

# This has also shown us a key difference between how arrays are passed as parameters either to a block or a method. When yielded to a block, an array's
# individual elements will get converted to a list of items if the block parameters call for that conversioni (such as when we have parameters like
# |apples, *assorted|) When passing an array to a method, we need to be explicit in how we pass it. If we want to change that array into a list of items,
# we'll have to do so with the * operator. Overall, it seems like like using a block is the right way to go, it allows
# more flexibility and leaves implementation of gather to the user.

# In our Ruby course content on blocks, we learn about symbol to proc and how it works

comparator = proc { |a, b| b <=> a }

# and the Array #sort method, which expects a block argument to express how the Array will be sorted. If we want to use comparator to
# sort the Array, we have a problemL it is a proc, not a block.

# The following code:

array.sort(comparator)

# fails with ArgumentError. To get around this, we can use the proc to block operator & to convert comparator to a block:

array.sort(&comparator)

This now works as expected, and we sort Array in reverse order.

When applied to an argument object for a method, a lone & causes ruby to try to convert that object to a block. If that object
is a proc, the conversion happens automatically, just as shown above. If the object is not a proc, then & attempts to call the
#to_proc method on the object first. Used with symbols eq &:to_s, Ruby creates a proc that calls the #to_s method on
a passed object, and then converts that proc to a block. This is the "symbol to proc" operation (though symbol to block makes more sense)

Note that &, when applied to an argument object is not the same as an & applied to a method parameter, as in this code:

def foo(&block)
  block.call
end

While & applied to an argument object causes the object to be converted to a block, & applied to a method
parameter causes the associated block to be converted to a proc. In essence, the two uses of & are opposites.

Did you know that 


# Let's start with out convert_to_base8 method. Notice that this method takes a
# number like argument, n. We also see that to_s(n) is using a number like argument
# as well. This seems like a good place to start. We'll find that this form of to_s
# converts integers into the String representation of a base -n number.

# Right now, we use decimals (base 10), so to convert a number n to base 8, we call
# to_s(8) on it. If we take 8 as an example, then calling 8.to_s(8) returns '10'. But,
# from the expected return value, we can see that we want an Integer, not a String.
# THerefore, we also need to call to_i on the return value of n.to_s(8).

# Next, let's handle the missing pieces of this line:

# base8_proc = method(argument).to_proc

# After looking at the method class documentation, we see that a symbol of an
# existing method may be passed into method method(sym). If we do that, the functionality
# of that method gets wrapped in a Method object, and we may now do work on that object.

# The final piece of this exercise asks us to fill in this line [8, 10, 12, 14, 16, 33].map(&a_proc)
# We want access to the functionality of method convert_base_to_8 

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


