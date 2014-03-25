require "gosu"

module BricksMeetBalls
  module Util
    def draw_square(window, x1, y1, x2, y2, color, z_order=0)
      window.draw_quad(x1, y1, color,
                       x2, y1, color,
                       x1, y2, color,
                       x2, y2, color,
                       z_order)
    end

    def draw_frame(window, x1, y1, x2, y2, color, z_order=0)
      window.draw_line(x1, y1, color,
                       x2, y1, color,
                       z_order)
      window.draw_line(x1, y1, color,
                       x1, y2, color,
                       z_order)
      window.draw_line(x1, y2, color,
                       x2, y2, color,
                       z_order)
      window.draw_line(x2, y1, color,
                       x2, y2, color,
                       z_order)
    end

    def hit?(x, y)
      x >= @x1 && x <= @x2 &&
      y >= @y1 && y <= @y2
    end

    def hit_on_top_or_bottom?(x, y)
      [(@x1 - x).abs, (@x2 - x).abs].min >=
      [(@y1 - y).abs, (@y2 - y).abs].min
    end

    def hit_on_left_or_right?(x, y)
      [(@x1 - x).abs, (@x2 - x).abs].min <
      [(@y1 - y).abs, (@y2 - y).abs].min
    end

    def out_from_left_or_right?(x)
      x <= @x1 ||
      x >= @x2
    end

    def out_from_top?(y)
      y <= @y1
    end

    def drop?(y)
      y > @y2
    end

    def base_dir
      @base_dir ||= File.expand_path(File.dirname(__FILE__))
    end
  end
end
