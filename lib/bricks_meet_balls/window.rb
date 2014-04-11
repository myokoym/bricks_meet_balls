require "gosu"
require "bricks_meet_balls/util"
require "bricks_meet_balls/z_order"
require "bricks_meet_balls/brick"
require "bricks_meet_balls/ball"
require "bricks_meet_balls/bar"
require "bricks_meet_balls/message"

module BricksMeetBalls
  class Window < Gosu::Window
    include Util

    attr_accessor :num_of_rows, :num_of_columns, :num_of_balls
    attr_accessor :ball_images, :brick_images
    attr_accessor :endless

    def initialize(width=240, height=480,
                   num_of_rows=2, num_of_columns=3, num_of_balls=1,
                   ball_images=nil, brick_images=nil, endless=false)
      super(width, height, false)
      self.caption = "Bricks meet Balls"
      @x1 = 0
      @y1 = 0
      @x2 = width
      @y2 = height
      @ball_images = ball_images
      @brick_images = brick_images
      @num_of_columns = num_of_columns
      @num_of_rows = num_of_rows
      @num_of_balls = num_of_balls
      @endless = endless
      @background_image = nil
      init
    end

    def init
      @bricks = []
      @balls = []
      @bar = Bar.new(self)
      @message = nil
    end

    def show
      @brick_width = self.width / @num_of_columns
      @brick_height = @brick_width / 3
      create_bricks(@num_of_columns, @num_of_rows)
      create_balls(@num_of_balls)
      super
    end

    def update
      friction = 0
      if button_down?(Gosu::KbLeft) ||
         button_down?(Gosu::MsLeft)
        @bar.move_left
        friction -= 15
      end
      if button_down?(Gosu::KbRight) ||
         button_down?(Gosu::MsRight)
        @bar.move_right
        friction += 15
      end

      @balls.each do |ball|
        ball.move

        @bricks.each do |brick|
          if brick.hit?(ball.x, ball.y)
            @bricks.delete(brick)
            ball.reflect(brick)
          end
        end
        if @bar.hit?(ball.x, ball.y)
          ball.reflect(@bar, friction)
        end
        if self.out_from_left_or_right?(ball.x)
          ball.reflect_y_axis
        elsif self.out_from_top?(ball.y)
          ball.reflect_x_axis
        end

        if self.drop?(ball.y)
          @balls.delete(ball)
        end
      end

      if @message.nil? && @balls.empty?
        if @endless
          create_balls(@num_of_balls)
        else
          @message = Message.new(self, "Game Over...")
        end
      end
      if @message.nil? && @bricks.empty?
        if @endless
          create_bricks(@num_of_columns, @num_of_rows)
        else
          @message = Message.new(self, "Congratulations!")
        end
      end
    end

    def draw
      draw_area
      draw_background_image if @background_image
      @bricks.each {|brick| brick.draw }
      @balls.each {|ball| ball.draw }
      @bar.draw
      @message.draw if @message
    end

    def button_down(id)
      case id
      when Gosu::KbSpace
        @balls.each do |ball|
          if ball.moving?
            ball.stop
          else
            ball.start
          end
        end
      when Gosu::KbInsert
        create_ball
      when Gosu::KbEscape
        close
      end
    end

    def background_image=(image_path)
      set_background_image(image_path)
    end

    def set_background_image(image_path)
      @background_image = Gosu::Image.new(self, image_path, false)
    end

    def enable_tiling_an_image_on_bricks
      @tiling_an_image_on_bricks = true
    end

    private
    def draw_area
      draw_square(self,
                  0, 0,
                  self.width, self.height,
                  Gosu::Color::WHITE, ZOrder::Background)
    end

    def draw_background_image
      width = 1.0 * self.width / @background_image.width
      height = 1.0 * @brick_height * @num_of_rows / @background_image.height
      @background_image.draw(0,
                             0,
                             ZOrder::Background,
                             width,
                             height)
    end

    def create_bricks(num_of_columns, num_of_rows)
      if @tiling_an_image_on_bricks
        if @brick_images.is_a?(Array)
          brick_image = @brick_images.sample
        else
          brick_image = @brick_images
        end
        tile_images = tiling(brick_image, num_of_columns, num_of_rows)
      end
      1.upto(num_of_rows) do |row|
        1.upto(num_of_columns) do |column|
          if @brick_images.is_a?(Array)
            brick_image = @brick_images.sample
          else
            brick_image = @brick_images
          end
          if @tiling_an_image_on_bricks
            image_index = (column - 1) + (num_of_columns * (row - 1))
            brick_image = tile_images[image_index]
          end
          @bricks << Brick.new(self,
                               column,
                               row,
                               @brick_width,
                               @brick_height,
                               brick_image)
        end
      end
    end

    def tiling(image_path, num_of_columns, num_of_rows)
      Gosu::Image.load_tiles(self,
                             image_path,
                             -1 * num_of_columns,
                             -1 * num_of_rows,
                             false)
    end

    def create_balls(n)
      n.times do
        create_ball
      end
    end

    def create_ball
      if @ball_images.is_a?(Array)
        ball_image = @ball_images.sample
      else
        ball_image = @ball_images
      end
      ball = Ball.new(self, ball_image)
      ball.warp(self.width  * 0.5,
                self.height * 0.8)
      @balls << ball
    end
  end
end
