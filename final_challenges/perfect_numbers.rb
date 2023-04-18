# problem: classify an argument as perfect, abundant, or deficient

# input: should be positive integer
# raise standard error if incorrect arg

# output: return string category

# D

# array of divisors
# integer

# A

# PerfectNumber

# classify(num)
# raise StandardError unless num is positive integer
# num <=> value(num)
# case string when 0 etc.


# value(num)
# array = [0]
# sqrrt = ((num ** (0.5) + 1).to_int
# sqrrt times |val|
#   if num % (val + 1) is 0
#     array << val + 1
#     array << num / (val + 1)
#   end
# end
# array.uniq.sum - num

# class PerfectNumber
#   def self.classify(num)
#     raise StandardError "Not a positive integer!" unless num.is_a?(Integer) && num > 0
#     case num <=> self.value(num)
#     when -1 then 'abundant'
#     when 0 then 'perfect'
#     else 'deficient'
#     end
#   end

#   def self.value(num)
#     array = [0]
#     sqrrt = ((num) ** (0.5)).to_int + 1

#     1.upto(sqrrt) do |val|
#       if num % val == 0
#         array << val
#         array << num / val
#       end
#     end

#     array.uniq.sum - num
#   end

#   private_class_method :value
# end