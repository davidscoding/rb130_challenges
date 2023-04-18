require 'pry'
require 'pry-byebug'

class Element
  attr_reader :datum, :next

  def initialize(input_datum, next_element = nil)
    @datum = input_datum
    @next = next_element
  end

  def tail?
    @next.nil?
  end
end

class SimpleLinkedList
  attr_reader :head
  
  def initialize
    @head = nil
  end

  def self.from_a(arr)
    arr = arr.clone
    list = self.new
    return list if arr.nil?

    while arr.length > 0
      list.push(arr.pop)
    end
    list
  end

  def reverse
    self.class.from_a(self.to_a.reverse)
  end

  def to_a
    arr = []
    # binding.pry
    placeholder = @head

    until placeholder.nil?
      arr.push(placeholder.datum)
      placeholder = placeholder.next
    end
    arr
  end

  def pop
    value = @head.datum
    @head = @head.next
    value
  end

  def peek
    return nil if @head.nil?
    @head.datum
  end

  def push(val)
    placeholder = @head
    @head = Element.new(val, placeholder)
  end

  def empty?
    size == 0
  end

  def size
    # binding.pry
    count = 0
    tracer = @head
    until tracer.nil?
      count += 1
      tracer = tracer.next
    end
    count
  end
end