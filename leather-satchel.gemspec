require './lib/leather/satchel/version'

Gem::Specification.new do |spec|
  spec.name = 'leather-satchel'
  spec.version = Leather::Satchel::VERSION
  spec.authors = [
    'Christopher Birmingham'
  ]
  spec.email = [
    'chris.birmingham@hotmail.co.uk'
  ]

  spec.summary = 'IOC Container for Ruby'
  spec.description = 'A fairly simple IOC container based off of silexphp/Pimple'
  spec.homepage = 'https://github.com/chrisBirmingham/leather-satchel'

  spec.files = Dir['lib/**/*'] + ['LICENSE']
  spec.license = 'Unlicense'

  spec.required_ruby_version = '>= 2.3'

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
end
