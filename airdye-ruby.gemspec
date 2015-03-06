# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'airdye/version'

Gem::Specification.new do |spec|
  spec.name          = "airdye-ruby"
  spec.version       = Airdye::VERSION
  spec.authors       = ["David Michael"]
  spec.email         = ["david.michael@giantmachines.com"]
  spec.summary       = %q{Write a short summary. Required.}
  spec.description   = %q{Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"


  # spec.add_development_dependency 'activerecord-sqlserver-adapter'
  # brew install freetds
  # spec.add_development_dependency 'tiny_tds'

  spec.add_runtime_dependency 'faraday'
  spec.add_runtime_dependency 'memoist'
  spec.add_runtime_dependency 'hashie'
  spec.add_runtime_dependency 'addressable'
  spec.add_runtime_dependency 'faraday_middleware'
  spec.add_runtime_dependency 'patron'
end
