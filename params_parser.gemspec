# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'params_parser/version'

Gem::Specification.new do |spec|
  spec.name          = "params_parser"
  spec.version       = ParamsParser::VERSION
  spec.authors       = ["Peter Swan", "Todd Mohney"]
  spec.email         = ["pdswan@gmail.com", "toddmohney@gmail.com"]
  spec.summary       = %q{Parse Parameters with key mapping, transformation, and defaults.}
  spec.description   = %q{Parse Parameters with key mapping, transformation, and defaults.}
  spec.homepage      = "https://github.com/gustly/params_parser"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "actionpack", "~> 5.2.8.1"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
end
