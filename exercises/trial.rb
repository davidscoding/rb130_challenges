# def test2
#   puts "hello"
#   yield
#   puts "good-bye"
# end

# def test(&block)
#   puts "1"
#   test2()block.call
#   puts "2"
# end

# test {|prefix| puts "xyz"}

# # => 1
# # hello
# # xyz
# # good-bye
# # => 2

require "pry"
require "pry-byebug"

# def test
#   yield
#   # "hello"
# end
# # binding.pry
# # puts (test do
# #   if true
# #     return "goodbye"
# #   end 
# #   5 + 5
# #   "work"
# # end)

# def proc_demo_method
#   proc_demo = Proc.new { return "Only I print!" }
#   proc_demo.call
#   "But what about me?" # Never reached
# end
# puts "hello?"
# puts proc_demo_method 
# # Output 
# # Only I print!

# def work
#   yield
# end
# binding.pry
# puts (work do
#   return "hello"
# end)

# def reduce(arr, acc = nil )
#   return nil if arr.length == 0
  
#   counter = 0
#   if acc.nil?
#     counter = 1 
#     acc = arr[0]
#   end

#   while counter < arr.length
#     acc = yield(acc, arr[counter])
#     counter += 1
#   end
#   acc
# end

# array = [1, 2, 3, 4, 5]

# p reduce(array) { |acc, num| acc + num }                    # => 15
# p reduce(array, 10) { |acc, num| acc + num }                # => 25
# # reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass

# p reduce(['a', 'b', 'c']) { |acc, value| acc += value }     # => 'abc'
# p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } # => [1, 2, 'a', 'b']

class Orange
  @@this = "nothing"

  def initialize
    @skin = "orangey"
    @family = "citrus"
  end

  def name
    Proc.new do |val|
      @@this = val
      self.family += " #{val} yup"
    end
  end

  def to_s
    @@this + " what else? " + family
  end

  private

  attr_accessor :family
end

r = Orange.new
new_o = r.name
new_o.call("hehe")
puts r
new_o.call("hoho")
puts r









# class Tester
#   attr_accessor :name
# end

# def floaty(item = Proc.new)
#   puts (item.call + "I'm floating with the " + item.call)
#   puts yield
# end

# def floater(&block)
#   block.call
#   floaty(block,&block)
# end

# counter = 0
# floater do 
#   counter += 1
#   binding.pry
#   testy = testy || nil
#   if counter == 1
#     testy = Tester.new
#     testy.name = 100
#   end
#   if testy
#     testy.name += 2
#     "hehe #{counter}, testy: #{testy.name}"
#   end
# end

# class Banana
#   def initialize
#     arr = %w(a b c d e)
#   end

#   def trial(proc)
#     arr.each {|val| proc.call(val)}
#   end
# end
# n = Proc.new {|item| puts item}
# fruit = Banana.new
# fruit.trial(&(&n))

# newp = Proc.new do
#   val = val || 0
#   val += 1
#   puts val
#   puts count
# end

# def tri(&b)
#   count = 0
#   # binding.pry
#   r = b.to_proc
#   r.call
# end

# tri(&newp)

class Adder
  attr_accessor :val

  def initialize(num = 0)
    self.val = num
  end

  def add_it(value)
    self.val += value.val
    self
  end

  def to_s
    val.to_s
  end
end


a = Adder.new
a.val = 6

b = Adder.new
b.val = 17

c = Adder.new
c.val = 142
# binding.pry
puts ([a, b, c].inject(&:add_it))
