#!/usr/bin/env ruby
#
# groonga-logo.png, groonga-icon-full-size.png:
#   CC BY 3.0 - (c) The Groonga Project
#
# mroonga-logo.png:
#   CC BY 3.0 - (c) The Mroonga Project
#
# rroonga-logo.png:
#   CC BY 3.0 - (c) The Ranguba Project
#
# nroonga-logo.png:
#   CC BY 3.0 - (c) The Nroonga Project
#
# droonga-logo.png:
#   CC BY 3.0 - (c) The Droonga Project
#

require "bricks_meet_balls"

BRICK_IMAGES = [
  "groonga-logo.png",
  "mroonga-logo.png",
  "rroonga-logo.png",
  "nroonga-logo.png",
  "droonga-logo.png",
]

width = 640
height = 480
num_of_rows = 10
num_of_columns = 8
num_of_balls = 29

base_dir = File.expand_path(File.dirname(__FILE__))
ball_image = File.join(base_dir, "groonga-icon-full-size.png")
brick_images = BRICK_IMAGES.collect do |brick_image|
  File.join(base_dir, brick_image)
end

window = BricksMeetBalls::Window.new(width,
                                     height,
                                     num_of_rows,
                                     num_of_columns,
                                     num_of_balls,
                                     ball_image,
                                     brick_images)

window.show
