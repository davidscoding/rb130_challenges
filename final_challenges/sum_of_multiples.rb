# Problem:

# sum of multiples less than target number

# initialize: default 3 and 5, can take in any number of integers
# edge cases: assume positive integers, and do different number of args

# return integer sum

# to(target)
# multuples = [0]
# each val in set
#   sum = val
#   while sum < target
#     multiples << sum
#     sum += val
#   end
# multiples.uniq!.sum


class SumOfMultiples
  def initialize(*args)
    @set = args
    @set = [3, 5] if args.empty?
  end

  def self.to(target)
    self.new.to(target)
  end

  def to(target)
    multiples = [0]
    @set.each do |val|
      multiple = val
      while multiple < target
        multiples << multiple
        multiple += val
      end
    end
    multiples.uniq.sum
  end
end
