require "gosu"
require "bricks_meet_balls/util"
require "bricks_meet_balls/z_order"

module BricksMeetBalls
  class Ball
    include Util

    attr_reader :x, :y

    def initialize(window, image_path=nil)
      @window = window
      @x = @y = 0.0
      @ball_radius = @window.height * 0.01
      @angle = 30 + (5.0 * [*1..10, *14..24].sample) - 90
      @speed = @window.height * 0.005
      @moving = true
      if image_path
        @ball_radius *= 2
        @image = Gosu::Image.new(@window, image_path, false)
      end
    end

    def draw
      if @image
        @image.draw(@x - @ball_radius,
                    @y - @ball_radius,
                    ZOrder::Ball,
                    2.0 * @ball_radius / @image.width,
                    2.0 * @ball_radius / @image.height)
      else
        draw_frame(@window,
                   @x - @ball_radius, @y - @ball_radius,
                   @x + @ball_radius, @y + @ball_radius,
                   Gosu::Color::BLACK, ZOrder::Ball)
      end
    end

    def warp(x, y)
      @x, @y = x, y
    end

    def move
      return unless @moving
      @x += Gosu.offset_x(@angle, @speed)
      @y += Gosu.offset_y(@angle, @speed)
    end

    def moving?
      @moving
    end

    def stop
      @moving = false
    end

    def start
      @moving = true
    end

    def reflect(target)
      if target.hit_on_top_or_bottom?(@x, @y)
        reflect_x_axis
      elsif target.hit_on_left_or_right?(@x, @y)
        reflect_y_axis
      end
    end

    def reflect_x_axis
      if @angle <= 180
        @angle = 180 - @angle
      else
        @angle = 360 - (@angle - 180)
      end
    end

    def reflect_y_axis
      if @angle <= 180
        @angle = 180 + (180 - @angle)
      else
        @angle = 360 - @angle
      end
    end
  end
end
