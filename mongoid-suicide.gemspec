lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid/suicide/version'

Gem::Specification.new do |spec|
  spec.name          = "mongoid-suicide"
  spec.version       = Mongoid::Suicide::VERSION
  spec.authors       = ["Anton Maminov"]
  spec.email         = ["anton.linux@gmail.com"]
  spec.summary       = %q{Hacks to support Mongoid remove field}
  spec.description   = %q{Hacks to support Mongoid remove field. Including associations and validations}
  spec.homepage      = "https://github.com/mamantoha/mongoid-suicide"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.7.0'
  spec.add_development_dependency "bundler", ">= 2.1.0"
  spec.add_development_dependency "rake", "~> 12.3.3"
  spec.add_development_dependency "mongoid", ['> 4.0', '< 9.0']
end
