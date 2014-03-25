# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bricks_meet_balls/version'

Gem::Specification.new do |spec|
  spec.name          = "bricks_meet_balls"
  spec.version       = BricksMeetBalls::VERSION
  spec.authors       = ["Masafumi Yokoyama"]
  spec.email         = ["myokoym@gmail.com"]
  spec.summary       = %q{A game template as Break the Bricks}
  spec.description   = %q{Bricks meet Balls is a game template as Break the Bricks using Gosu and Ruby.}
  spec.homepage      = "https://github.com/myokoym/bricks_meet_balls"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) {|f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency("gosu")

  spec.add_development_dependency("test-unit")
  spec.add_development_dependency("test-unit-notify")
  spec.add_development_dependency("test-unit-rr")
  spec.add_development_dependency("bundler", "~> 1.5")
  spec.add_development_dependency("rake")
end
