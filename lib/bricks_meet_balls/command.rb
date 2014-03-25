require "bricks_meet_balls/window"

module BricksMeetBalls
  class Command
    class << self
      def run
        window = Window.new
        window.show
      end
    end
  end
end
