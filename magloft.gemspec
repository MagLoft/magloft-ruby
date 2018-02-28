lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'magloft/version'

Gem::Specification.new do |s|
  s.name        = "magloft"
  s.version     = Magloft::VERSION
  s.licenses    = ["BSD-3-Clause"]
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tobias Strebitzer"]
  s.email       = ["tobias.strebitzer@magloft.com"]
  s.homepage    = "https://github.com/magloft/magloft-ruby"
  s.summary     = "MagLoft API Client"
  s.description = "magloft allows you to connect your system to the MagLoft API"
  s.required_ruby_version = '~> 2.3'
  s.required_rubygems_version = '~> 2.4'
  s.add_dependency "activesupport", '>= 4.0', '< 6.0'
  s.add_dependency "bundler", '>= 1.3.0', '< 2.0'
  s.add_dependency "her", '~> 0.10'
  s.add_development_dependency "pry", "~> 0.11"
  s.add_development_dependency "rubocop", "~> 0.52.1"
  s.files        = Dir["README.md", "lib/**/*"]
  s.require_path = 'lib'
end
