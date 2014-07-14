Gem::Specification.new do |s|
  s.name        = 'mongoid_embed_denorm'
  s.version     = '0.0.1'
  s.author      = 'John Shields'
  s.email       = 'johnnyshields@gmail.com'
  s.homepage    = 'https://github.com/johnnyshields/mongoid_embed_denorm'
  s.summary     = 'Mongoid denormalization via embedded models'
  s.description = 'Stay classy with an object-oriented approach to Mongoid denormalization.'
  s.license     = 'MIT'

  s.files        = Dir['{config,lib,spec}/**/*'] + %w(README.md CHANGELOG.md LICENSE)
  s.require_path = 'lib'

  s.add_dependency 'mongoid', '>= 3.0'
  s.add_development_dependency 'rspec', '~> 2.14.1'
end
