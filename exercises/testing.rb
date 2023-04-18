# # Every method in ruby already takes a block

# def hello
#   "hllo"
# end

# hello #=> "hllo"

# # This is super simple
# # If was call it with an argument:

# hello('hi')

# # This gives us an argument error. It doesn't work because Ruby
# # isn't expecting any arguments

# However, it we call it with a block:

# hello{puts 'hi'} #=> "hllo"

# # In Ruby, every method can take an optional block as an
# # implicit argument. You can just tack it on at the end of the method invocation,
# # just like we did above when calling the hello method.

# # One way we can invoke the passed in block from within the method
# # is by using the yield keyword:

# def echo_with_yield(str)
#   yield
#   str
# end

# echo_with_yield() {puts "world"} #=> arg error
# echo_with_yield("Hello"){puts "world"} #=> world => hello
# echo_with_yield("hello", "earth") #=> arg error

# # only the middle call doesn't generate errors. We see two things:

# # 1) The number of arguments at method invocation needs to mathc
# # the method definition, regardless of whether we are passing in a block
# # 2) The yield keyword executes the block

# # A developer using your method can come in after this method
# # is fully implemented and inject additional code in the middle of the method
# # without modifying the method implementation by passing in a block of code.

# # This is one of the major use cases of using blocks.

# # If we call the method without a block, we get a local jump error:

# echo_with_yield("hello!") #=> error

# # If we get this error, there is a yield in the method implementation,
# # but not in the invocation.

# # In order to allow this method call with or without a block, we
# # must somehow wrap the yield call in a conditioinal: only call yield
# # when a block is passed to the method. We can achieve this with the
# # Kernel #block_given? method Because its Kernel, its available everywhere.

# def echo_with_yield(str)
#   yield if block_given?
#   str
# end

# # Now we can call echo_with_yield with or without a block. If a block
# # is passed in, the block_given? will be true and our code will yield
# # to the block (ie execute the block code). If a block is not passed in,
# # the block_given? will be false and the only thing the method will do is
# # return str

# echo_with_yield("Hello")
# echo_with_yield("Hello"){puts "World"}

# both work now!

# # Passing execution to the block

# # method implementation
# def say(words)
#   yield if block_given?
#   puts "> " + words
# end

# # method invocation
# say("hi there") do
#   system 'clear'
# end

# Before we can trace the code execution, we have to be
# clear that def say... code is the method implementation and
# say... is the method invocation. There is only one method
# here: say. Sometimes, when we're passing in a block of code,
# the method invocation can contain more code than the method
# implementation, which makes it easy to confuse the two.

# We can start tracing the code execution:

# 1) Execution starts at method invocation on line 8. The `say`
# method is invoked with two arguments: a string and a block. (The
# block is an implicit parameter and not part of the method definition)
# 2) Execution goes to line 2, where the method local variable words is
# assigned to the string "hi there". The block is passed in implicitly,
# without being assigned to a variable.
# 3) Execution continues into the first line of the method implementation,
# line 3, which immediately yields to the block.
# 4) The block, line 9, is now executed, which clears the screen.
# 5) After the block is done executing, execution continues in the the
# method implementation on line 4. Executing line 4 results in the output
# being displayed.
# 6 The method ends, which means the last expressions value is returned by this
# method. The last expression in the method invokes the puts method,
# so the return value is nil

# Notice the jump after line 3: execution jumps to somewhere else,
# then comes back to finish the rest of the method. This is similar to calling
# a method, except we're calling a block. This is why it's sometimes
# useful to think of a block as an unnamed or anonymous method. If you had
# trouble tracing the code execution flow in the above examplpe

# Sometimes, the bloock we pack in to a method requires an argument. Note
# that the block itself is an argument into a method, so the face that the
# block requires an argument adds an additional layer of complexity. But we've 
# already been writing blocks that take an argument for a long time:

# 3.times do |num|
#   puts num
# end

# 3 is the calling object
# .times is the method
# the do .. end is the block, which is passed in as an argument to the method
# |num| is the parameter for the block
# within the block num is a block local variable

# It's important to make sure the block parameter has a unique name and doesn't conflict
# with any local variables outside the scope of the block. Otherwise, you'll encounter
# variable shadowing. Shadowing makes it impossible to access the variable defined in the
# outer scope, which is not usually what we want. 

# Let's write our own method that takes a block with an argument. Suppose we 
# want to write a method called increment that takes a number as an argument, and 
# returns the argument incremented by 1. At implementation time, we don't want to output
# the incremented number, because we aren't sure how users will use this method.
# The only thing we can be sure of is that the method should take an argument
# and return the argument pluc one.

# def increment(number)
#   number + 1
# end

# increment(5) #=> 6

# # Say we want to allow for users to possible to take some action on the newly
# # incremented number at method invocation time. For example, maybe some users want
# # to print it out or others want to log it to a file, or send it to Twitter. We want
# # to allow for some flexibility at method usage or invocation time. Blocks are perfect for this
# # Let's update the implementation to yield to a block, and pass in the incremented number
# # into the block.

# #method implementation
# def increment(number)
#   if block_given?
#     yield(number + 1)
#   end
#   number + 1
# end

# # method invocation
# increment(5) do |num|
#   puts num
# end

# 1) Execution starts at method invocation on line 10
# 2) Execution moves to the method implementation on line 2, which Sets 5 
# to the local variable number, and the block is not set to any variable; itself
# is just implicitly available
# 3) Execution continues to line 3 which is a conditioinal
# 4) Our method invocation has indeed passed in a block so the conditional is true
# moving execution to line 4
# 5) On line 4 execution is yielded to the block (or the block is called), and we're
# passing number + 1 to the block. This means we're calling the block with 6 as the
# block argument
# 6) Execution jumps to line 10 where the block parameter num is assigned to 6
# 7) Execution continues to line 11, where we output the block local variable num
# 8) Execution continues to line 12, where the end of the block is reached.
# 9) Execution now jumps back to the method implementation, where we jsut finished
# executing line 4
# 10) Execution continues to line 5, the end of the if
# 11) Line 6 returns the value of the incremented argument to line 10.
# 12) The program ends (the return value of increment is not used)

# # Once again, calling a boock is almost like calling another method. In this case, we're
# # even passing an argument to the block, just like we could for any normal method.

# # Now that you understand how passing an argument to a block works, maybe you're thinking
# # "what would happen if I pass in the wrong number of arguments to a block?" Would ruby raise
# # an Argument Error, like it would for normal me3thods??????????????
# # Let's give it a try:

# # method implementation
# def test
#   yield(1,2)
# end

# # method invocation
# test { |num| puts num }

# The extra block argument is ignored.

# # method implementation
# def test
#   yield(1)    # passing 1 block argument at block invocation time
# end

# # method invocation
# test do |num1, num2| # expecting 2 parameters in block implementation
#   puts "#{num1} #{num2}"
# end

# # We try again with too few arguments, in this case we bind the remaining
# # parameters to nil. The rule regarding number of arguments is that you must pass block, proc,
# # or lambda in Ruby is called its arity. IN ruby blocks and procs have lenient
# # arity, which is why ruby doesn't complain when we pass too few or too many arguments.
# # to the block. Methods and lambdas on the other hand have strict arity, which
# # means you must pass the exact number of arguments that the method or lambda expects.
# # For now, the main thing you should remember about arity is that methods enforce
# # the argument count, while blocks do not.

# # Suppose we want to write a method that outputs the before and after of 
# # manipulating the argument to the method. For example, we'd like to invoke a
# # compare method that does this:

# compare('hi') { |word| word.upcase }

# # Output:
# # Before: hi
# # After: HI

# def compare(str)
#   puts "Before: #{str}"
#   after = yield(str)
#   puts "After: #{after}"
# end

# compare("hello") { |word| word.upcase }

# From the above example, you can see that the after local variable
# in the compare method implementation is assigned the return value from
# the block. This is yet another behavior of blocks that's similar
# to methods: they havew a return value and that return value is determined by
# the last expression evaluated by the block. This implies that just like normal
# methods, blocks can either mutate the argument with a destructive method call
# or the block can return a value. Just like writing good normal method, writing good
# blocks requires you to keep this distinction in mind. We could further
# $$$ Check back over mutation versus meaningful return value

# We could further call this compare method with a variety of different block
# implementations.

# compare('hello') { |word| word.slice(1..2)}

# # Before: hello
# # After el
# #=> nil

# compare('hello') { |word| "nothing to do with anything" }

# # Before: hello
# # After: nothing to do with anything
# # => nil

# In these two examples, pay attention to the return value of the block. That's what the
# compare method implementation is relying on to display in the "After" scenario.
# Once you understand the basic use case of our compare method, let's study a slightly
# trickier example.

# compare('hello') { |word| puts "hi" }

# # Before: hello
# # hi
# # After:
# # => nil

# Within the block, we output hi, and then that puts method call returns nil

# There are many ways that blocks can be useful, here are the two main use cases:

# 1) Defer some implementation code to method invocation decision.

# There are two roles involved with any method: the method implementor and the
# method user. There are times when the method implementor is not 100% sure of how that
# method will be called. Maybe they are 90% certain, but they want to leave that
# 10% decision up to the method user at method invocation time.

# If we don't have blocks, the method implementor can allow the method user to pass in
# some flag. For example, we tak the compare method. We can achieve similar functionality:

# def compare(str, flag)
#   after = case flag
#           when :upcase
#             str.upcase
#           when :capitalize
#             str.capitalize
#           # etc, we could have a lot of 'when' clauses
#           end

#   puts "Before: #{str}"
#   puts "After: #{after}"
# end

# compare("hello", :upcase)

# # Before: hello
# # After: HELLO
# # => nil

# # But this isn't so flexible as providing a way for method users to
# # refine the method implementation, without actually modifying the method
# # implementation for everyone else. By using blocks, the method implementor can
# # defer  the decision of which flags to support and let the user
# # decde at method invocation time. The method implementor is saying I'll set it up
# # so you can refine things later since you understand the scenario better.

# # Many of the core libraries most useful methods are useful precisely because they
# # are built in a generic sense, allowing use (the method users) to refine the method
# # through a block at invocation time. For example, tkae the Array #select method
# # We love the select method because we can pass in any expression that evaluates to a
# # boolean in the block parameter. The select method is built in a generic way, allowing
# # the user to pass refinement ti the method implementation

# # If you encounter a scenario where you're calling a method from multiple
# # places, with one little tweak in each case, it may be a good idea to try implementing
# # the method in a generic way by yielding to the block.

# # Methods that need to perform some before and after actions - sandwich code

# Sandwich code is a code example of the previous point about deferring implementation to method
# invocation. There will be times when you want to write a generic method that
# performs a before and after action. Before what? that's the point. The method
# implementor doesn't care. Suppoze we want to write a method that outputs how long
# something take. Our method doesn't care what that something it; our method just
# cares about displaying how long it takes, Our method doesn't care what that something is
# our method just cares about displaying how long it took. THe outline could look
# like this:

# def time_it
#   time_before = Time.now
#   yield
#   time_after = Time.now

#   puts "It #{time_after - time_before} seconds."
# end


# time_it { sleep(3) }              # It took 3.003767 seconds.
#                                   # => nil

# time_it { "hello world" }         # It took 3.0e-06 seconds.
#                                   # => nil
# The sleep method there just pauses execution for however many seconds
# you pass in. You can see that our time_it method does exactly what we want: It
# times the code passed into it. In order to time it, we need to capture the time
# before execution, then compare it with the time after. 

# There are many useful situations for sandwich code. Timing logging and notification
# systems are all good examples where beffore/after actions are important.

# Another are where before/after actions are important is in resource management. Many outside
# interfaces require you to first allocate a portion of a resource, and then perform some
# clean-up to free up that resource. Forgetting to the cleanup could result in massive bugs. system crashes
# memory leaks, file system corruption. Wouldn't it be great if we could automate this clean up?


# This is exactly what the file::open method does for us.

# my_file = File.open("some_file.txt", "w+")
# my_file.close

# That last line closes the file and releases the my_file object from hanging
# on to system resources -- specifically the "some_file.txt". Since we always
# want to close files, File::open can also take a block, and will automatically
# close the file after the block executed.

# Using block syntax, we can do this:

# File.open("some_file.txt", "w+") do |file|
#   #doing stuff
# end

# Why is it that we don't have to close this file? Without understanding how blocks
# work, it's not obvious what the magic is. But now that you understand how yield works
# you can guess that the method implementor of File::open opens the file, yields to the
# block, and then closes the file. This means the method user only needs to pass in the
# relevant file manipulation code in the block without worrying about closing the file.

# Explicit block parameters:

# The last topic we want to discuss is passing a block to a method explicitly. Until now,
# we've passed blocks to methods implicitly. Every method, regardless of its definition,
# tkaes and implicit block. It may ignore the implicit block, but it still accepts it. 

# However, there are times when you want a method to take an explicit block; and explicit block
# is a block that gets treated as a named object --- that is, it gets assigned to a method parameter
# so that it can be managed like any other object - it can be reassigned, passed to other methods,
# and invoked many times. To define an explicit block, you simply add a parameter with the method
# definition where the name begins with the &character. 

# def test(&block)
#   puts "What's a &block? #{block}"
# end

# That looks a bit odd. The &block is a special parameter that converts the
# block argument to what we call a simple Proc object. Notice that we drop the
# & when refering to the parameter inside the method. Let's inoke the method to see
# what happens:

# test { sleep(1) }
# # What's &block? #<Proc:0x007f98e32b83c8@(irb):59>
# # => nil

# We see the block local variable is now a Proc object. we can name it however we please,
# just as long as we define it with a leading &. 

# So, what's the point? We were doing fine yielding to an implicit block. Why do we now need
# an explicit block instead? Chiefly, the answer is that it provides additional flexibility. Before,
# we didn't have a handle for the implicit block, so we couldn't do much with it except yield
# to it and test whether a block was provided. Now we have a variable that represents the block, so
# we can pass the block to another method.

# def test2(block)
#   puts "hello"
#   block.call
#   puts "good-bye"
# end

# def test(&block)
#   puts "1"
#   test2(block)
#   puts "2"
# end

# test {|prefix| puts "xyz"}

# test { |prefix| puts "xyz" }
# # => 1
# # hello
# # xyz
# # good-bye
# # => 2

# Note that you only need to use the & for the block parameter in #test
# Since block is already a Proc object when we call test2, no conversion is needed.
# Note that we also use block.call inside of test2 to invoke the Proc instead
# of yield. 

# It's not often that you need to pass a block around like this, but
# the need does arise. I should be familiar. I'll see it later.

# You can also pass arguments to the explicit block by using them as arguments
# to call:

# def display(block)
#   block.call(">>>")
# end

# def test(&block)
#   puts "1"
#   display(block)
#   puts "2"
# end

# test { |prefix| puts prefix + "xyz" }
# # => 1
# # >>>xyz
# # => 2

# Closures are formed by blocks, procs and lambdas. They retain
# a memory of their surrounding scope and can use and even update
# variables in that scope when they are executed, even if the block
# Proc or lambda is called from somewhere else. For instance:

# def for_each_in(arr)
#   arr.each { |element| yield element}
# end

# arr = [1, 2, 3, 4, 5]
# results = [0]

# for_each_in(arr) do |number|
#   total = results[-1] + number
#   results.push(total)
# end

# p results #=> [0, 1, 3, 6, 10, 15]

# Though the block passed to for_each_in is invoked from inside
# for_each_in, the block still has access to the results array through closure.

# Where closures really shine though, is when a method or block returns
# a closure. We can't return blocks, but we can return Procs. We'll
# demonstrate this with Procs, Lambdas are very similar.

# def sequence
#   counter = 0
#   Proc.new = { counter += 1 }
# end

# s1 = sequence
# p s1.call #1
# p s1.call #2
# p s1.call #3
# puts

# s2 = sequence
# s2.call #1
# s1.call #4
# s2.call #2

# Here, the #sequence method returns a Proc that forms a closure
# with the local variable counter. Subsequently, we can call the returned
# Proc repeatedly. Each time we do it, it increments its own private
# copy of counter. Thus when we call sequence a second time and assign
# the return value to s2, the counter associated with s2 is separate
# and independent of the counter in s1.

# We'll cover closures in far more detail later in the curriculum, though
# not with Ruby. For now, just remember that methods and blocks can return
# Procs and Lambdas that can subsequently be called.

# Blocks are one way Ruby implements closures. Closures are a way to pass
# around an unnamed "chunk of code" to be executed later.

# Blocks can take arguments, just like normal methods. But unlike normal methods,
# it won't complain about the wrong number of arguments.

# Blocks return a value, just like normal methods.

# Blocks are a way to defer some implementation decisions to method invocation
# time. It allows method users to refine a method at invocation time for a specific
# use case. It allows method implementors to create a generic method that can be
# used in a variety of ways.

# Blocks are a good use case for "sandwich code" scenarios, like closing a File automatically.

# Methods and blocks can return a chunk of code by returning a Proc or lambda.


