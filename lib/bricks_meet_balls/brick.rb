require "gosu"
require "bricks_meet_balls/util"
require "bricks_meet_balls/z_order"

module BricksMeetBalls
  class Brick
    include Util

    def initialize(window, x, y, width, height, image_path=nil)
      @window = window
      @width = width
      @height = height
      @margin = @width * 0.01
      @border_width = @width * 0.01 + @margin
      @x1 = 1.0 * @width  * (x - 1)
      @y1 = 1.0 * @height * (y - 1)
      @x2 = 1.0 * @width  * x
      @y2 = 1.0 * @height * y
      if image_path
        @image = Gosu::Image.new(@window, image_path, false)
      end
    end

    def draw
      draw_square(@window,
                  @x1, @y1,
                  @x2, @y2,
                  Gosu::Color::WHITE, ZOrder::Brick)
      draw_frame(@window,
                 @x1, @y1,
                 @x2, @y2,
                 Gosu::Color::BLACK, ZOrder::Brick)
      return unless @image
      @image.draw(@x1 + @border_width,
                  @y1 + @border_width,
                  ZOrder::Brick,
                  (0.95* @width  / @image.width),
                  (0.95 * @height / @image.height))
    end
  end
end
