require "simplecov"
SimpleCov.start

require "minitest/autorun"
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test
  def setup
    @register = CashRegister.new(1000)
    @transaction = Transaction.new(100)
  end

  def test_accept_money
    @transaction.amount_paid = 100

    previous_amount = @register.total_money
    @register.accept_money(@transaction)
    current_amount = @register.total_money

    assert_equal(previous_amount + 100, current_amount)
  end

  def test_change
    @transaction.amount_paid = 150
    assert_equal(50, @register.change(@transaction))
  end

  def test_give_receipt
    receipt = "You've paid $100.\n"
    assert_output(receipt) { @register.give_receipt(@transaction) }
  end
end

# When you first consider this test, it may seem simple, but there;s a lot.
# First we create some objects of CashRegister and Transaction to test #accept_money

# Once we have our objects, we set amount paid via the setter method in ATransaction
# If our method does work as intended then whne we process a transaction the amount should
# increase by the amount paid.

# For this test, we'll be testing that our method ouotputs a certain message. To test this, we
# need to use the assertion assert_output. Outputting a message is also considered a side effect,
# so it is something we would would want to test. This is especially true since our message should
# reflect a state of our current transaction. assert_output uses a slightly different syntax than
# assert_equal. We pass in code that will produce the actual ooutput via a block. Then, internally
# assert_output compares that output to the expected value passed in as an argument. In the case
# that expected valie is. Notice that we include a newline character at the end there. Any little nuances
# related to the implementation of the method must be taken into account. puts appends a newline.

# For this exercise we'll have to work on two things. First, we'll create a mock obejct to use in
# test_prompt_for_payment. output = StringIO.new Unlike when we created a mock object for input
# we don't have a String for out mock. We'll end up calling StringIO#puts on output and that is what
# will set the String value for our StringIO mock object. Second, we have to alter the Transaction#prompt_for_payment
# that will allow us to pass in an output mock object. def prompt_for_payment(input: $stdin, output: $stdout) Then
# we use this output mock object within our method, we call StringIO#puts and the string
# passed to puts gets stored within the StringIO object. It isn't ooutput to the user. Doing this should
# allow for us to clean up our testing output that displays when running minitest.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sed vulputate ipsum.
Suspendisse commodo sem arcu. Donec a nisi elit. Nullam eget nisi commodo, volutpat
quam a, viverra mauris. Nunc viverra sed massa a condimentum. Suspendisse ornare justo
nulla, sit amet mollis eros sollicitudin et. Etiam maximus molestie eros, sit amet dictum
dolor ornare bibendum. Morbi ut massa nec lorem tincidunt elementum vitae id magna. Cras
et varius mauris, at pharetra mi.

class Text
  def initialize(text)
    @text = text
  end

  def swap(letter_one, letter_two)
    @text.gsub(letter_one, letter_two)
  end
end