# fact = Enumerator.new do |y|
#   a = b = 1
#   index = 2
#   loop do
#     y << a
#     a, b = b, index * b
#     index += 1
#   end
# end

# p fact.take(7)
# p fact.take(3)

# fact1 = Object.new

# def fact1.each(val)
#   a = b = 1
#   index = 2
#   loop do
#     break if val + 2= < index
#     yield(a)
#     a, b = b, index * b
#     index += 1
#   end
# end

# p fact1.each(7) {|v| puts v}
# p fact1.each(3) {|v| puts v}

# # Group 1
my_proc = proc { |thing| puts "This is a #{thing}." }
puts my_proc
puts my_proc.class
my_proc.call
my_proc.call('cat')

# Group 2
my_lambda = lambda { |thing| puts "This is a #{thing}." }
my_second_lambda = -> (thing) { puts "This is a #{thing}." }
puts my_lambda
puts my_second_lambda
puts my_lambda.class
my_lambda.call('dog')
my_second_lambda.call('dog')
# my_lambda.call
# my_third_lambda = Lambda.new { |thing| puts "This is a #{thing}." }

# Group 3
def block_method_1(animal)
  yield
end

block_method_1('seal') { |seal| puts "This is a #{seal}."}
# block_method_1('seal')

# Group 4
def block_method_2(animal)
  yield(animal)
end

block_method_2('turtle') { |turtle| puts "This is a #{turtle}."}
block_method_2('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end
block_method_2('turtle') { puts "This is a #{animal}."}