#!/usr/bin/env ruby
#
# groonga-logo.png, groonga-icon-full-size.png:
#   CC BY 3.0 - (c) The Groonga Project
#

require "bricks_meet_balls"

width = 640
height = 480
num_of_rows = 10
num_of_columns = 8
num_of_balls = 29

base_dir = File.expand_path(File.dirname(__FILE__))
ball_image = File.join(base_dir, "groonga-icon-full-size.png")
brick_image = File.join(base_dir, "groonga-logo.png")

window = BricksMeetBalls::Window.new(width,
                                     height,
                                     num_of_rows,
                                     num_of_columns,
                                     num_of_balls,
                                     ball_image,
                                     brick_image)

window.show
