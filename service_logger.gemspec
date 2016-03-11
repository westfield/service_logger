# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'service_logger/version'

Gem::Specification.new do |spec|
  spec.name          = "service_logger"
  spec.version       = ServiceLogger::VERSION
  spec.authors       = ["Kisha Michelle Richardson"]
  spec.email         = ["kisha.richardson@gmail.com"]

  spec.summary       = "Structured Logging support for Westfield Api micro services"
  spec.description   = "Structured Logging to support Westfield Api micro services"
  spec.homepage      = 'https://github.com/westfield/service_logger'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-byebug'

  spec.add_runtime_dependency 'activesupport', '>= 4', '<= 5.0.0.beta2'
  spec.add_runtime_dependency 'actionpack', '>= 4', '<= 5.0.0.beta2'
  spec.add_runtime_dependency 'railties', '>= 4', '<= 5.0.0.beta2'

  spec.add_runtime_dependency 'lograge'
  spec.add_runtime_dependency 'logstash-event'
  spec.add_runtime_dependency 'logstash-logger'

end
