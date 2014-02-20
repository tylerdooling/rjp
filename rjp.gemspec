# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rjp/version'

Gem::Specification.new do |spec|
  spec.name          = "rjp"
  spec.version       = Rjp::VERSION
  spec.authors       = ["Tyler Dooling"]
  spec.email         = ["me@tylerdooling.com"]
  spec.description   = %q{A command line tool for formatting JSON and extracting values}
  spec.summary       = %q{A command line tool for formatting JSON and extracting values}
  spec.homepage      = "https://github.com/tylerdooling/rjp"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_dependency "awesome_print"
end
