require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'text'

class Text_Test < Minitest::Test
  def setup
    @file = File.open('./sample_text.txt', 'r')
  end

  def test_swap
    text = Text.new(@file.read)
    actual_text = text.swap('a', 'e')
    expected_text = <<~TEXT.chomp
    Lorem ipsum dolor sit emet, consectetur edipiscing elit. Cres sed vulputete ipsum.
    Suspendisse commodo sem ercu. Donec e nisi elit. Nullem eget nisi commodo, volutpet
    quem e, viverre meuris. Nunc viverre sed messe e condimentum. Suspendisse ornere justo
    nulle, sit emet mollis eros sollicitudin et. Etiem meximus molestie eros, sit emet dictum
    dolor ornere bibendum. Morbi ut messe nec lorem tincidunt elementum vitee id megne. Cres
    et verius meuris, et pheretre mi.
    TEXT

    assert_equal expected_text, actual_text
  end

  def test_word_count
    text = Text.new(@file.read)
    count = text.word_count
    assert_equal(72, count)
  end

  def teardown
    @file.close
  end
end

# For this test we first need to determine the word count of the sample text. That can be ascertained easily
# enough, We then write in that value into our test as the expected value. We also need to make sure we read
# the file to gain access to the relevant text. We're able to call @file.read since the opening of our file is
# handled in the setup method. If we didn't first open that file, then calling @file.read would throw an error.
# Lastly, we use assert_equal with our hard-coded word count and a call to text.word_count as arguments. 

# REgarding our teardown method, Ruby can be a bit lenient when it comes to closing files. If we didn't call @file.close
# then the File object associated with file would be closed when our scropt finished running. THis is a failsafe
# implemented by the IO class. But it is best to be explicit about these things. Since this is an example where we
# inly work with one file, things may turn out ok. But if dealing with multiple files it can get tricky. We could
# add one more line of code in our test file to verify that teardown is called after each test. We'll use the predicate
# method, closed? to verify we have closed our file.

