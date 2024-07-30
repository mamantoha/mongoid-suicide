# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid/suicide/version'

Gem::Specification.new do |spec|
  spec.name          = 'mongoid-suicide'
  spec.version       = Mongoid::Suicide::VERSION
  spec.authors       = ['Anton Maminov']
  spec.email         = ['anton.linux@gmail.com']
  spec.summary       = 'Hacks to support Mongoid remove field'
  spec.description   = 'Hacks to support Mongoid remove field. Including associations and validations'
  spec.homepage      = 'https://github.com/mamantoha/mongoid-suicide'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 3.1.0'
  spec.add_dependency 'mongoid', '> 4.0', '< 11.0'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
