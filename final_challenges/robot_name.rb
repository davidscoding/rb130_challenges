# Problem:

# upon initialization, we generate new name (random)
# if we need to reboot a robot it should regenerate a new name (random)
# We should not allow the use of the same name twice
# letter letter digit digit digit

# Data Structures

# class variable with array of names
# string for name

# Algo

# initialize
# calls reboot and sets name to return

# reboot
# random.new
# loop
#   calls generate_name
#   breaks unless name exists
# end
# inserts name into names array (class variable)

# generate_name
#   [l,l,d,d,d].join
# end

# l
# sampler.rand(A to Z)

# d
# sampler.rand(0 to 9)

class Robot
  attr_reader :name
  @@names = []

  def initialize
    @name = nil
    @sampler = Random.new
    reset
  end

  def reset
    loop do
      @name = generate_name
      break unless @@names.include?(name)
    end
    @@names << name
  end

  private

  def generate_name
    [l,l,d,d,d].join
  end

  def l
    ('A'..'Z').to_a.sample
  end

  def d
    ('0'..'9').to_a.sample
  end
end
