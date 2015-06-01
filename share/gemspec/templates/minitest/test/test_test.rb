require 'minitest_helper'

class TestTest < Minitest::Test
  def test_true_is_not_nil
    refute_nil true
  end

  def test_it_does_something_useful
    assert false
  end
end
