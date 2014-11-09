# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'agnostic_slugs/version'

Gem::Specification.new do |spec|
  spec.name          = "agnostic_slugs"
  spec.version       = AgnosticSlugs::VERSION
  spec.authors       = ["Lasse Skindstad Ebert"]
  spec.email         = ["lasse@lasseebert.dk"]
  spec.summary       = %q{Slug generator that is agnostic about ORMs}
  spec.homepage      = "https://github.com/lasseebert/agnostic_slugs"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0.0'
end
