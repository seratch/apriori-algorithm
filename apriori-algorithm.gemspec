# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'apriori'

Gem::Specification.new do |spec|
  spec.name          = "apriori-algorithm"
  spec.version       = Apriori::VERSION
  spec.authors       = ["Kazuhiro Sera"]
  spec.email         = ["seratch@gmail.com"]
  spec.summary       = %q{Apriori Algorithm implementation in Ruby}
  spec.description   = %q{Apriori Algorithm implementation in Ruby}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard-rspec'
end
