# File reading:

file = File.new('./filename.txt', 'read')
string = file.read
file.close

# Multiple arguments:

For closures or methods, we use the * operator for multiple
objects of unknown quantity

array = [1, 2, 3, 4, 5]
new_proc = proc { |first, *middle, last| "#do something" }
new_proc = proc { |first, *last| "#do something" }
new_proc = proc { |first, second, *last| "#do something" }
new_proc = proc { |*first, last| "#do something" }
new_proc = proc { |*all| "#do something" }

The big difference between methods and blocks here is that we can pass in a 
straight array to block and its elements are turned into a list of items if the 
blocks items call for such a conversion. ex:

new_proc.call(array)

When passing an array to a method, we need to be explicit in how we pass it. If We
want to convert it to a list, we have to use the * operator when we pass it in:

my_method(*array)

#Method objects

We can create method objects that can be converted to procs by calling the object
method, #method. Because we write out code within the context of `main` which is an
object, we can omit the caller and write the command as such (example with the puts 
method):

method(:puts)

These method objects can then be converted to procs with the `to_proc` method.

# Testing

#assert_output

We use assert_output with a block that contains the code execution.

# StringIO Input

We can modify our methods to take in parameters for the input like so:

def my_method(input: $stdin)
  @value = input.gets.chomp.to_f
  puts @value
end

This makes it so that we can add an argument for the input (a StringIO object)
to change the input from the standard input of the keyboard temporarily. We call the
methods we typically would, but instead of on Kernel, we call them on the object we
passed in.

input = StringIO.new("30\n")
my_method(input: input)

# StringIO Output

We can do a similar thing with the output, but passing in a blank StringIO instance
that is assigned the default of $stdout, we can swallow up the output in our testing
so that our testing output is a bit cleaner.

def my_method(input: $stdin, output: $stdout)
  @value = input.gets.chomp.to_f
  output.puts @value
end

output = StringIO.new
my_method(output: output)

# Setup and Teardown with File
def setup
  @file = File.new(`sample.txt`, `read`)
end

def test_something
  input = file.read
end

def teardown
  @file.close
end

# Enumerators

Enumerators are created by calling Enumerator.new and passing in a block with one
argument (yielder) that uses the shovel operator to take in the successive values in
the Enumerator. 

We can externally iterate through the Enumerator using the #next method and we can
rewind to the beginning with the #rewind method.

Typically we've seen internal iteration thus far with methods like #map and #each.
Enumerables (different) require an each method implementation as well as a <=> method
if we want access to the sorting methods.

#Procs, Lambdas, and Blocks:

1) A new proc object can be created with a cal of proc instead of Proc.new
2) A Proc is an object of class Proc
3) A Proc object does not require that the correct number of arguments are passed to
it. If nothing is passed, then nil is assigned to the block variable.

1) A new Lambda object can be created with a call to lambda or ->(parameters){}
We can't create a new lambda with Lambda.new
2) A Lambda is actually a variety of Proc
3) While Lambda is a Proc, it maintains a separate identity from a plain proc. This
can be seen when displaying a Lambda: the string shows an extra 'lambda' that isn't
there for normal Procs.
4) A lambda enforces the number of arguments. If the expected number of arguments are
not passed to it, then an error is thrown.

1) A block passed to a method does not require the correct number of arguments. If a block
variable is defined, and no value is passed to it, then nil will be assigned to it.
2) If we have a yield keyword and no block is passed, an error will be thrown.

1) If we pass too few arguments to a block, then the remaining ones are assigned to nil
2) Blocks will throw an error if a variable is referenced that doesn't exist in the block's
scope

1) Lambdas are types of Procs. Technically they are both Proc Objects. An implicit block
is a grouping of code, a type of closure, and it is not an Object.
2) Lambdas enforce the number of arguments passed to them. Implicit blocks and Procs
do not enforce number of arguments passed in.
