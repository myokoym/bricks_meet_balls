require "bricks_meet_balls"

class WindowTest < Test::Unit::TestCase
  def setup
    @window = BricksMeetBalls::Window.new
  end

  def test_init
    assert_not_nil(@window)
  end
end
