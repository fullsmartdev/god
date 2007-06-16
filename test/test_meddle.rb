require 'test_helper'

class TestMeddle < Test::Unit::TestCase
  def setup
    @meddle = Meddle.new
  end
  
  def test_should_initialize_watches_to_empty_array
    assert_equal [], @meddle.watches
  end
  
  def test_watches_should_get_stored
    watch = nil
    @meddle.watch { |w| watch = w }
    
    assert_equal 1, @meddle.watches.size
    assert_equal watch, @meddle.watches.first
  end
end