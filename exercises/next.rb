# Let's put what we've learned thus far into practice. Let's
# write our own times method that mimics the behavior of the 
# integer #times method. First lets study the times method:

# 5.times do |num|
#   puts num
# end

# Invoking the #times method produces the following output:

# 0
# 1
# 2
# 3
# 4
# #=> 5

# Notice that the #times method's first block argument is 0,
# and the last block argument is 1 less than the calling object.
# Finally, the method returns the calling object, 5. 

# Our times method will exhibit the same behavior. We don't have a
# calling object, but we do have a method argument, so we'll return
# that. In other words, we should be able to write the following code and
# get identical output as Integer#times:

# # Let's give it a shot:

# def times(number)
#   counter = 0
#   while counter < number do
#     yield(counter)
#     counter += 1
#   end
  
#   number
# end

# times(5) do |num|
#   puts num
# end


# We'll trace it out:

# # 1 Method invocation starts at line 39, when the times method is
# called with an argument, 5, and a block of code.
# # 2 Execution enters the first line of the method implementation
# at line 29, where the local variable counter is initialized.
# # 3 Execution continues to line 30. The while conditional is evaluated.
# The first time through, the condition is true.
# # 4 Execution continues to line 31, which yields to the block. This
# is the same as executing the block of code, and this time, we are executing
# the block of code with an argument. The argument to the block is the
# counter, which is 0 the first time through.
# # 5 Execution jumps to line 39, so that the block local variable num is assigned
# to the object referenced by counter, ie num is assigned to 0.
# # 6 Execution continues in the block to line 40, which outputs the block local
# variable num. 
# # 7 Reaching the end of the block, execution continues back to the times method
# implementation on line 6, where the counter is incremented. 
# # 8 Reaching the end of the while loop, execution continues on line 31, essentially repeating
# steps 3-7.
# # 9 At some point, the while conditional should return false (otherwise
# you have an infinite loop) allowing execution to flow to line 36, which doesn't do 
# anything.
# # 10 Reaching the end of the method at line 37, execution will return the last expression
# in this method, which is the number local variable.


# This example is made a little bit more complicated by the while loop, but pay attention to
# the interplay between method implementation and the block. From within the method, we are yielding
# execution to the block, and we are passing an argument to the block. When we call the method, we know
# that we must include a block that takes an argument.

# In other words, there are two separate roles here: the times method implementer and the
# user of the times method. For this we'll call the method implementer Isaac, and the user
# Uni. Both are developers, so the roles her are just in relation to the times method.

# Isaac wants to write a generic times method, and he doesn't know if users of the method will
# be outputting values or adding them together, or whatever. All he wants to do is write a generic method that
# iterates up to a certain number. Using a block is a perfect use case; he can allow users of his method to
# us blocks to perform some action. But he doesn't know what that action is, so all he is responsible
# for is to yield to the block and pass to the block the current number. This is the inspiration for out implementation
# of our times method. 

# On the other hand, Uni has the need to iterate up to a certain number throughout her code. She
# finds Isaacs times method and decides to use it. She reads the documentation and finds good examples.
# This fits her needs perfectly, as long as she passes in an argument to the method, and a block takes an
# argument. She can then be sure that the argument to her block is going to be a number starting from
# 0, up to 1 less than the argument she passed to the method. This is how Isaac implemented
# the method, and what he wrote in the documentation.

# Up to this point, you've been using the Integer# times or Array#each by relying on documentation.
# We're now starting to see how Isaac implements these method, so you can start implementing these types of
# generic methods in your own code.

# Let's now try to apply what we knwo about blocks and build our own each method. By now, we're familiar with 
# Array#each, and we'll be using that method as our inspiration. One subtley to note is that the Array#each method returns
# the calling object at the end. Example:

# [1,2,3].each { |num| "do nothing" }

# So what happens is that hte Array #each method iterates through the array, yielding each
# element to the block, where the block can do whatever it needs to do to each element. Then the method
# returns the calling object. This is so developers can chain methods on afterwords, like this:

# [1,2,3].each{|num| "do nothing"}.select{ |num| num.odd? }

# Let's write our own each method:

# def each(array)
#   counter = 0

#   while counter < array.length
#     yield(array[counter])
#     counter += 1
#   end

#   array
# end

# # Note that we used a loop, specifically, a while loop in the implementation
# # of the each method. Because we return the argument at the end, we can even chain it.

# # This is very similar to our Array#each method.

# # The entire magic of our each method relies on the fact that our method does not
# # implement what action to perform when iterating through the array. Do we increment every
# # value by one? Do we output the element? None of that matters, because our each method is solely
# # focused on iterating and not anything beyond that. Writing a generic iterating method allows method
# # callers to add additional implementation details at method invocation time by passing in a block.
# # This is why when we implemented the method, we yield to the block. Notice that the trick here is
# # to pass the current element we're working with to the block. At each iteration within the while loop
# # execution then goes to the block with the current element as the block argument and will return
# # execution back to the while loop after executing the block. Then, counter is incremented and the while
# # loop continues and the next element is yielded to the block.

# # def select(array)
# #   new_arr = []

# #   each(array) do |element|
# #     new_arr << element if yield(element)
# #   end

# #   new_arr
# # end


# # Reduce:

# [1, 2, 3].reduce do |acc, num|
#   acc + num
# end

# # => 6 

# Let's take this apart: the [1, 2, 3] is the caller; the reduce is the method call;
# and the do...end is the block.

# def reduce(arr, acc = arr[0]) 
#   counter = 0
#   while counter < arr.length
#     acc = yield(arr[counter], acc)
#   end
#   acc
# end


# In this assignment, we're going to create a TodoList which contains
# a collection of Todo objects. Internally to TodoList, we'll use an Array to back the collection
# of Todo objects. We'll first look at the Todo class:

# class Todo
#   DONE_MARKER = 'X'
#   UNDONE_MARKER = 'O'

#   attr_accessor :title, :description, :done

#   def initialize(title, description='')
#     @title = title
#     @description = description
#     @done = false
#   end_index

#   def done!
#     self.done = true
#   end

#   def done?
#     done
#   end

#   def undone!
#     self.done = false
#   end

#   def to_s
#     "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
#   end

#   def ==(otherTodo)
#     title == otherTodo.title &&
#       description == otherTodo.description &&
#       done == otherTodo.done
#   end
# end

# # The above is a simple Todo class that contains 3 attributes each
# # Todo object can have: a title, a description, and a boolean flag to
# # designate whether the todo item is "done". We have 3 helper methods
# # to set, unset, and interrogate the @done attribute; the aren't strictly
# # necessary, but give a better interface when working with Todo objects.
# # Finally, we provide a to_s method for representing Todo objects as strings,
# # and an == method that lets us compare two Todo objects for equality. We can
# # use this class in our TodoList class below to encapsulate todo items.

# # Examples with Todo class:

# todo1 = Todo.new("Buy milk")
# todo2 = Todo.new("Clean room")
# todo3 = Todo.new("Go to gym")

# puts todo1
# puts todo2
# puts todo3

# # [ ] Buy milk
# # [ ] Clean room
# # [ ] Go to gym

# # The puts methods automatically calls the argument's to_s method, which in this
# # case leads to the Todo#to_s method. The return vlaue of any
# #   puts call is nil. Let's say bought some milk, so we want to
# #   update the todos:

# todo1.done!

# puts todo1
# puts todo2
# puts todo3

# # Pretty neat! There's not too much beyond this functionality for
# # Todo objects. We create them, we can mark them done or undone, then we can
# # display them. 

# # Let's now turn our attention to the collection class, TodoList.
# # Why build our own? Can't we jsut use array? We could but using our
# # own custom collection class allows us to add additional attributes
# # to the collection, and also allows for us to add additional behaviors
# # to specific todo lists. For example, our collection of Todo objects should have
# # a title, or perhaps a due date. Using array doesn't allow us to add these collection
# # level attributes. We could also append two TodoList objects together to
# # get a new TodoList, but we can't do that with Array (we'd get a new array).
# # We could further define specific requirements about what types of objects
# # this list should have. For example, out TodoList should only work with Todo
# # objects, and using our own custom class we can enforce this requirement. We can't
# # use an Array. Sometimes, using Ruby's basic collections is enough, other times
# # we need more.

# # Take a look at the initial implementation of the TodoList class:
# # Note we use Array as the backing mechanism internally to keep track of
# # Todo objects. We can easily change it ot a hash or linked list or whatever
# # in the future, as long as our TodoList public interface doesn't change.

# # Key take away: custom collection classes allow for us to add additional attributes,
# # additional custom methods, and limits to the objects passed in as elements to the collection.
# # We can change the underlying mechanism (ie which collection type we use to hold that objects)
# # as long as we don't change to the public interface and we won;t cause issues (flexibility)

# class Todo
#   DONE_MARKER = 'X'
#   UNDONE_MARKER = 'O'

#   attr_accessor :title, :description, :done

#   def initialize(title, description='')
#     @title = title
#     @description = description
#     @done = false
#   end_index

#   def done!
#     self.done = true
#   end

#   def done?
#     done
#   end

#   def undone!
#     self.done = false
#   end

#   def to_s
#     "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
#   end

#   def ==(otherTodo)
#     title == otherTodo.title &&
#       description == otherTodo.description &&
#       done == otherTodo.done
#   end
# end

# class TodoList
#   attr_accessor :title

#   def initialize(title)
#     @title = title
#     @todos = []
#   end

#   def size
#     @todos.size
#   end

#   def first
#     @todos.first
#   end

#   def last
#     @todos.last
#   end

#   def shift
#     @todos.shift
#   end

#   def pop
#     @todos.pop
#   end

#   def done?
#     @todos.all? { |todo| todo.done? }
#   end

#   def <<(todo)
#     raise TypeError, "can only add Todo object" unless todo.instance_of? Todo

#     @todos << todo
#   end

#   # alias_method :new_method, :old_method

#   alias_method :add, :<<

#   def item_at(idx)
#     @todos.fetch(idx)
#   end

#   def mark_done_at(idx)
#     item_at(idx).done!
#   end

#   def mark_undone_at(idx)
#     item_at(idx).undone!
#   end

#   def done!
#     @todos.each_index do |index|
#       mark_done_at(index)
#     end
#   end

#   #whenever faced with the option to use object method or current class method,
#   #rely upon methods established within the current class. If you need to tweak
#   #how the getter method works in the context of collections in the future, you only
#   #need to do it once. (ie mark_done_at vs done! on each object)

#   def remove_at(idx)
#     @todos.delete(item_at(idx))
#   end

#   def each
#     counter = 0
#     while counter < size
#       yield item_at(counter)
#       counter += 1
#     end
#     self
#   end

#   def to_s
#     text = "=== #{title} ==="
#     text << @todos.map(&:to_s).join("\n")
#     text
#   end

#   def to_a
#     @todos.clone
#   end
# end

# # The TodoList class is pretty straightforward, but there are a couple
# # of interesting pieces worth noting.

# # Since #add and #<< behave the same, we defined one of them and then just
# # aliased the other.
# # Note that in #<< we're raising a TypeError if the parameter is not a Todo object

# # You can play aroudn with the class to get a feel for its behaviors

# # Given our final Todo and TodoList class from the previous assignment, implement a TodoList#each method.
# # This method should behave similarly to the familiar Array#each, and the each method we built
# # ourselves in an earlier example. The TodoList #each should take a block, and yield each Todo Object to the block.

# # yield the block parameter to the block.

# todo1 = Todo.new("Buy milk")
# todo2 = Todo.new("Clean room")
# todo3 = Todo.new("Go to gym")

# list = TodoList.new("Today's Todos")
# list.add(todo1)
# list.add(todo2)
# list.add(todo3)

# list.each do |todo|
#   puts todo                   # calls Todo#to_s
# end

# # What does that give us?

# # Now, we have a standard way to iterate through a TodoList object. Suppose we have
# # the 3 todoes from earlier in a list, we can now iterate:

# # # list.each {|todo| #actions }

# # Why go through the trouble of implementing a way to iterate through items in a TodoList
# # when we already have a way? Can't we just expose the @todos array and let users of the class
# # iterate through that array directly?

# # attr_reader :todos

# # The one additional line of code above gives user of the TodoList class a getter method for the 
# # @todos internal state. Now we can do this:

# list.todos.each do |todo|

# end

# In most cases, we prefer to work with the TodoList object directly and invoke
# methods calls on list. We would rather now access an internal state of the TodoList, which
# in this case is @todos. This is the idea behind encapsulation: we want to hide implementation details
#   from users of the TodoList class, and not encourage them to reach into its internal state. Instead
#   we want to encourage users to use the interfaces (public methods) we created for them.

# For example, when we add a new todo into the list, we would rather use TodoList#add, rather than work
# with the TodoList#todos getter method and modify the array. This is because TodoList contains a rule to
# check that all items are instances of Todo. Therefore, we enforce this rule in TodoList#add. If we bypass
# that method, then all of a sudden that rule is no longer being enforced. Even if you can bypass it, allow
# the class implementer to enforce their rules; its probably there for a reason.

# Likewise, we prefer to use TodoList#each over reaching into the @todos array. Suppose later
# on we no longer want the internal representation to be an array. That is, @todos should be some other
# data structure. In that case, we'd need a different mechanism to iterate over the items in TodoList. It can't
# be Array#each anymore because it's no longer an array. Internal to the TodoList class, all we have to
# do is change the TodoList#each method. We'd need to figure out a new way to iterate through the linked list, or hash
# or whatever. Users of the TodoList class shouldn't feel any change at all, if they use TodoList#each. That
# method will still behave the same to users of the TodoList class; it will still iterate through the items,
# yielding each Todo object at every iteration. However, if users of the TodoList class had instead reached into the
# @todos variable directly, then their code will break. Since @todos is no longer an array, this code may no longer
# work. list.todos.each { |todo| }

# The entire goal of creating a class and encapsulating logic in a class is to hide implementation details and contain
# ripple effects when things change. Prefer to use the class's interface where possible.

# Let's do a select method with the TodoList:


class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = 'O'

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def done?
    @todos.all? { |todo| todo.done? }
  end

  def <<(todo)
    raise TypeError, "can only add Todo object" unless todo.instance_of? Todo

    @todos << todo
  end

  # alias_method :new_method, :old_method

  alias_method :add, :<<

  def item_at(idx)
    @todos.fetch(idx)
  end

  def mark_done_at(idx)
    item_at(idx).done!
  end

  def mark_undone_at(idx)
    item_at(idx).undone!
  end

  def done!
    @todos.each_index do |index|
      mark_done_at(index)
    end
  end

  #whenever faced with the option to use object method or current class method,
  #rely upon methods established within the current class. If you need to tweak
  #how the getter method works in the context of collections in the future, you only
  #need to do it once. (ie mark_done_at vs done! on each object)

  def remove_at(idx)
    @todos.delete(item_at(idx))
  end

  def each
    counter = 0
    while counter < size
      yield item_at(counter)
      counter += 1
    end
    self
  end

  def select
    new_todo_list = TodoList.new(title)
    self.each { |todo| new_todo_list << todo if yield(todo) }
    new_todo_list
  end

  def to_s
    text = "=== #{title} ==="
    text << @todos.map(&:to_s).join("\n")
    text
  end

  def to_a
    @todos.clone
  end
end


todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

todo1.done!

results = list.select { |todo| todo.done? }    # you need to implement this method

puts results.inspect

# key takeaway: when working with lists its always good to consider the return value
# of the method as well as the action itself. Especially consider the class of the return value.
# If we're supposed to return the current instance (as in each) return self.



class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = 'O'

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def done?
    @todos.all? { |todo| todo.done? }
  end

  def <<(todo)
    raise TypeError, "can only add Todo object" unless todo.instance_of? Todo

    @todos << todo
  end

  # alias_method :new_method, :old_method

  alias_method :add, :<<

  def item_at(idx)
    @todos.fetch(idx)
  end

  def mark_done_at(idx)
    item_at(idx).done!
  end

  def mark_undone_at(idx)
    item_at(idx).undone!
  end

  def done!
    @todos.each_index do |index|
      mark_done_at(index)
    end
  end

  #whenever faced with the option to use object method or current class method,
  #rely upon methods established within the current class. If you need to tweak
  #how the getter method works in the context of collections in the future, you only
  #need to do it once. (ie mark_done_at vs done! on each object)

  def remove_at(idx)
    @todos.delete(item_at(idx))
  end

  def each
    counter = 0
    while counter < size
      yield item_at(counter)
      counter += 1
    end
    self
  end

  def select
    new_todo_list = TodoList.new(title)
    each() do |todo| 
      new_todo_list << todo if yield(todo)
    end
    new_todo_list
  end

  def find_by_title(string)
    select { |todo| todo.title == string }[0]
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(string)
    find_by_title(string) && find_by_title(string).done!
  end

  def mark_all_done
    each { |todo| todo.done! }
  end

  def mark_all_undone
    each { |todo| todo.undone! }
  end

  def to_s
    text = "=== #{title} ==="
    text << @todos.map(&:to_s).join("\n")
    text
  end

  def to_a
    @todos.clone
  end
end



Now that we understand what blocks are, let's revisit local variable scope

Recall that previously we asked you to memorize local variable scope in terms of
inner and outer scope, as determined by where the local variable was initialized.
A block creates a new scope for local variables, and only outer local variables are 
accessible to inner blocks.'

level_1 = "outer most variable"

[1,2,3].each do |n|
  level_2 = "inner variable"

  ['a','b', 'c'].each do |n2|
    level_3 = "inner-most variable"
    #123 accessible
  end
  #23 accessible
end
#1 accessible

# This is only for local variables. It's even more confusing because sometimes we're
# invoking methods, but they look just like local variables if you omit the parentheses.
# Always look at where the local variable was initialized to determine its scope, and to verify
# that it's indeed a local variable we're dealing with, and not a method. If its a method,
# it doesn't follow this rule. 

# As we talked about before, a block is how Ruby implements the idea of closure, which is a general
# computing concept of a "chunk of code" that you can pass around in your codebase. In order
# for this "chunk of code" to be executed later, it must understand the surrounding context from
# 'where it was defined. In Ruby this "chunk of code" is represented by a Proc, a lambda, or a block.

# name = "Robert"
# chunk_of_code = Proc.new {puts "hi #{name}"}

# If you try to run that code, nothing apparent will happen. That's because we've created a Proc adding
# saved it to chunk_of_code, but haven't executed it yet. We can now pass around this local variable, chunk_of_code,
# and execute it later. Suppose we have a completely different method and we pass the chunk_of_code Proc
# into that method, then the method executes the Proc. THink it through and check it out:


# def call_me(some_code)
#   some_code.call
# end

# name = "Robert"
# chunk_of_code = Proc.new {puts "hi #{name}"}

# call me(chunk_of_code)

# Read the above, and think about what you know about variable scoping rules

# hi Robert

# Note that the Proc identified by some_code knew how to handle puts #{name} and
# specifically, that it knew how to process the name variable. How did it do that?
# THe name variable was initialized outside the method definition and we know that in Ruby,
# local variables initialized outside of a method aren't accessible inside of the method.
# So again, how did the code we passed know how to process the name variable?

# Maybe that Proc was pre-processed somehow? Let's run an experiment to test that theory.
# We'll use the same code, except we'll reassign the name variable after the Proc has
# been initialized. Let's see if the chunk of code retains it's old value of Robert
# or our new value of "Griff III"'

def call_me(some_code)
  some_code.call
end

name = "Robert"
chunk_of_code = Proc.new { puts "hi #{name}"}
name = "Griffin III"

call_me(chunk_of_code)

The output is:

hi Griffin III

Whoa. The Proc is aware of the new value even though the variable was reassigned after the
Proc was defined. This implies that the Proc keeps track of its surrounding context, and
drags it around whereever the chunk of code is passed to. In ruby, we call this its
binding or surrounding environment/ context. A closure must keep track of its binding to
have all the information it needs to be executed later. This not only includes local variables
but also method references, constants and other artifacts in your code -- whatever it needs
to executes correctly, it will drag around. It's why code like the above works fine
seemingly violating the variable scoping rules we learned earlier. Note that any
local variables that need to be accessed by a closure must be defined before the closure
is created, unless the local variable is explicitly passed to the closure when it is called.

IN the code from the last example, removing name = "Robert" on line 5 would change the binding of
the Proc object on line 6: name would no longer be in scope since it is initialized only afte Proc
is instantiated.

Bindings and closures are at the core of variable scoping rules in RUby. 

When working with collections, we often want to transform all items in that collection. FOr example, suppose
we have an array of integers and we want to transform every element into an array of strings. We can do this:

[1,2,3,4,5].map do |num|
  num.to_s
end

# => ["1", "2", "3", "4", "5"]

You can see the return value for the above is a new array, where every element is now
a string. This type of code is so common that there's a shortcut for it. We could write
the above like this:

[1,2,3,4,5].map(&:to_s)

The above code iterates through every element in the array and calls to_s on it, then
saves the result into a new array. After its done iterating, the new array is returned. And cbecause
it returns another array, you could chain another transformation.

[1,2,3,4,5].map(&:to_s).map(&:to_i)

the above code transforms all elements to strings and then back to integers. Note that
the & must be followed by a symbol name for a method that can be invoked on each element.
IN the last example, we use the symbols :to_s and :to_i to represent the #to_s and #to_i
methods. 

Suppose you want to use String#prepend to prepend each value with the string "The number is:"
Unfortunately, we can't use the shortcut to do that; it doesn't work for methods that take arguments.

Finally, this shortcut will work with any collection method that takes a block, not only map:

["hello", "world"].each(&:upcase!)
[1,2,3,4,5].select(&:odd?)
[1,2,3,4,5].select(&:odd?).any?(&:even?)

Symbol #to_proc

If you look closely, somehow this code: (&:to_s)
gets converted to this code: {|n| n.to_s }

What's the mechanism at work here? Although it's related to the use of & with explicit
block, this is something else baecause we're not working with explicit blocks here. 

Explicit blocks can be identified by looking our for an & in the parameter list for a method

Instead, we're applying the & operator to an object (possibly referenced by a variable), and when
this happens Ruby tries to convert the object to a block. That's easy if the object is a Proc - converting
a Proc to a block is something that Ruby can do naturally. However, if the object is not
  already a Proc, we have to first convert it to a Proc. In that case, we call the #to_proc method on
the object, which returns a Proc. Ruby can then convert the resulting Proc to a block.

In the example above, this is what's happening:

&:to_s tells Ruby to convert the :to_s symbol to a block
  Since :to_s is not a Proc Ruby first calls Symbol#to_proc to convert the symbol to a Proc
  Now that it is a Proc, Ruby converts this Proc to a block

def my_method
  yield(2)
end  
# turns the symbol into a Proc, then & turns the Proc into a block
my_method(&:to_s)               # => "2"  

def my_method
  yield(2)
end

a_proc = :to_s.to_proc #explicitly call to_proc on the symbol
my_method(&a_proc) # convert Proc into block, then pass block in. Returns "2"

The main concept you have to know here is that you can use a shortcut when calling methods with blocks by using the symbol to
proc trick. But understand there's some depth behind the syntax. 

Blocks are just one way Ruby implements closures. Procs and Lambdas are others.

Closures drag their surrounding context/ environment around, and this is at the core of how variable
scope works.

blocks are great for pushing some decisions to method invocation time

blocks are great at wrapping logic, where you need to perform some before/after actions

We can write our own methods that take a block with the yield keyword

When we yield, we can also pass arguments to the block

When we yield, we have to be aware of the blocks return value

Once we understand blocks, we can re-implement many of the common methods in the Ruby Core library in our own classes

The Symbol#to_proc is a nice shortcut when working with collections

How to return a chunk of code (a closure) from a method or block (typically return a Proc)

def 



