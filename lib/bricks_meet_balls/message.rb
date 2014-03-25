require "gosu"
require "bricks_meet_balls/util"
require "bricks_meet_balls/z_order"

module BricksMeetBalls
  class Message
    def initialize(window, text)
      @window = window
      font_height = @window.width * 2 / max_length_each_lines(text)
      line_spacing = @window.height / 20
      @text = Gosu::Image.from_text(@window,
                                    text,
                                    Gosu.default_font_name,
                                    font_height,
                                    line_spacing,
                                    @window.width,
                                    :center)
    end

    def draw
      @text.draw(0, @window.height / 3,
                 ZOrder::Message,
                 1, 1,
                 Gosu::Color::BLACK)
    end

    def max_length_each_lines(text)
      max_length = 0
      text.each_line do |line|
        if max_length < line.length
          max_length = line.length
        end
      end
      max_length
    end
  end
end
