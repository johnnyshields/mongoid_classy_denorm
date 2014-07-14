$:.push File.expand_path('../lib', __FILE__)
require 'mongoid/embed_denorm/version'

Gem::Specification.new do |s|
  s.name         = 'mongoid_embed_denorm'
  s.version      = Mongoid::EmbedDenorm::VERSION
  s.author       = 'John Shields'
  s.email        = 'johnnyshields@gmail.com'
  s.homepage     = 'https://github.com/johnnyshields/mongoid_embed_denorm'
  s.summary      = 'Mongoid denormalization via embedded models'
  s.description  = 'Stay classy with an object-oriented approach to Mongoid denormalization.'
  s.license      = 'MIT'
  s.post_install_message = File.read('UPGRADING') if File.exists?('UPGRADING')

  s.files        = Dir['{config,lib}/**/*'] + %w(README.md CHANGELOG.md LICENSE)
  s.test_files   = Dir['spec/**/*']
  s.require_path = 'lib'

  s.add_dependency 'mongoid', '>= 3.0'
  s.add_development_dependency 'rspec', '~> 2.14.1'
end
