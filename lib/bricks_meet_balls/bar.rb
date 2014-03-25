require "gosu"
require "bricks_meet_balls/util"
require "bricks_meet_balls/z_order"

module BricksMeetBalls
  class Bar
    include Util

    def initialize(window)
      @window = window
      @width  = @window.width  * 0.3
      @height = @window.height * 0.01
      @x1 = @window.width  * 0.5
      @y1 = @window.height * 0.9
      @x2 = @x1 + @width
      @y2 = @y1 + @height
      @movement = @width * 0.04
    end

    def draw
      draw_square(@window,
                  @x1, @y1,
                  @x2, @y2,
                  Gosu::Color::BLACK, ZOrder::Bar)
    end

    def move_left
      @x1 -= @movement
      @x2 = @x1 + @width
    end

    def move_right
      @x1 += @movement
      @x2 = @x1 + @width
    end
  end
end
