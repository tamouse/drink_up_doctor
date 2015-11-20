# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'drink_up_doctor/version'

Gem::Specification.new do |spec|
  spec.name          = "drink_up_doctor"
  spec.version       = DrinkUpDoctor::VERSION
  spec.authors       = ["Tamara Temple"]
  spec.email         = ["tamouse@gmail.com"]

  spec.summary       = %q{jekyll+gulp}
  spec.description   = %q{jekyll+gulp}
  spec.homepage      = "https://github.com/tamouse/drink_up_doctor"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "jekyll"
end
