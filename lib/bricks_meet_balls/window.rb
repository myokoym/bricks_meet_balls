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

    def initialize(width=240, height=480,
                   num_of_rows=2, num_of_columns=3, num_of_balls=1,
                   ball_images=nil, brick_images=nil, endless=false)
      super(width, height, false)
      self.caption = "Bricks meet Balls"
      @x1 = 0
      @y1 = 0
      @x2 = width
      @y2 = height
      @bricks = []
      @balls = []
      @bar = Bar.new(self)
      @message = nil
      @ball_images = ball_images
      @brick_images = brick_images
      @num_of_columns = num_of_columns
      @num_of_rows = num_of_rows
      @num_of_balls = num_of_balls
      @endless = endless
      create_bricks(@num_of_columns, @num_of_rows)
      create_balls(@num_of_balls)
      @background_image = nil
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

    def set_background_image(image_path)
      @background_image = Gosu::Image.new(self, image_path, false)
    end

    private
    def draw_area
      draw_square(self,
                  0, 0,
                  self.width, self.height,
                  Gosu::Color::WHITE, ZOrder::Background)
      return unless @background_image
      @background_image.draw(0,
                             0,
                             ZOrder::Background,
                             1.0 * self.width  / @background_image.width,
                             0.5 * self.height / @background_image.height)
    end

    def create_bricks(num_of_columns, num_of_rows)
      1.upto(num_of_columns) do |column|
        1.upto(num_of_rows) do |row|
          if @brick_images.is_a?(Array)
            brick_image = @brick_images.sample
          else
            brick_image = @brick_images
          end
          @bricks << Brick.new(self,
                               column,
                               row,
                               self.width / num_of_columns,
                               self.width / num_of_columns / 3,
                               brick_image)
        end
      end
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
