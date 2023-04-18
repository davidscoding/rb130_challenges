# require 'pry'
# require 'pry-byebug'

# Worked through creating an inject/reduce object that could take in an enumerable
# collection and run inject/reduce (for all type, not just arrays). There were 5
# main situations to consider:

#   1) Just a symbol argument
#   2) Starting value and symbol argument (doesn't care if block given)
#   3) Starting value and block input
#   4) Just a block argument
#   5) Invalid input

# I created a guard clause at the beginning of inject for the exception and then
# made a case statement for the other 4 private methods.

class Injection
  def initialize(collection)
    @collection = collection
  end

  def self.inject(collection, injected = nil, symbol = nil, &block)
    self.new(collection).inject(injected, symbol, &block)
  end

  def inject(injected = nil, symbol = nil, &block)
    raise TypeError.new unless symbol.is_a?(Symbol) || symbol.is_a?(String) || symbol.nil?
    case
    when symbol then injected_symbol(injected, symbol)
    when injected && block_given? then injected_block(injected, &block)
    when injected && !block_given? then injected_solo(injected)
    else block_call(&block)
    end
  end

  alias :reduce :inject 
  
  private

  attr_reader :collection

  def injected_symbol(injected, symbol)
    collection.each do |val|
      injected = injected.method(symbol).call(val)
    end
    injected
  end
  
  def injected_block(injected)
    collection.each do |val|
      injected = yield(injected, val)
    end
    injected
  end
  
  def block_call()
    injected = nil
    collection.each_with_index do |val, index|
      if index == 0
        injected = val
        next
      end
      injected = yield(injected, val)
    end
    injected
  end
  
  def injected_solo(injected)
    block_call(&injected)
  end
end

i = Injection.new((1..5))
h = Injection.new({a:1, b:2, c:3, d:4, e:5})
p i.reduce(:+)
p h.reduce(:zip)
p i.reduce(0, :+){|prod, val| prod * val} == 15
p i.reduce(5, :+){|prod, val| prod * val} == 20
p i.reduce(){|prod, val| prod * val} == 120
p i.reduce(2){|prod, val| prod * val} == 240