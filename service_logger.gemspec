# coding: utf-8
require_relative 'lib/service_logger/version'

Gem::Specification.new do |spec|
  spec.name          = 'service_logger'
  spec.version       = ServiceLogger::VERSION
  spec.authors       = ['Kisha Michelle Richardson']
  spec.email         = ['kisha.richardson@gmail.com']

  spec.summary       = 'Structured Logging support for micro services.'
  spec.description   = 'Structured Logging to support micro services.'
  spec.homepage      = 'https://github.com/westfieldlabs/service_logger'
  spec.license       = 'Apache 2.0'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.2.2'

  spec.add_dependency 'activesupport', '>= 4', '< 5.1'
  spec.add_dependency 'actionpack', '>= 4', '< 5.1'
  spec.add_dependency 'railties', '>= 4', '< 5.1'
  spec.add_dependency 'lograge', '~> 0.4.1'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry', '~> 0.10.3'
  spec.add_development_dependency 'pry-byebug', '~> 3.3'
end
