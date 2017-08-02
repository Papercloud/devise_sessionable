$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "devise_sessionable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "devise_sessionable"
  s.version     = DeviseSessionable::VERSION
  s.authors     = ["Isaac Norman"]
  s.email       = ["isaacdnorman@gmail.com"]
  s.homepage    = "https://github.com/Papercloud/devise_sessionable"
  s.summary     = "Session Authentication with tokens"
  s.description = "Use session objects for token authentication"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "> 4.2.7", "< 6.0"
  s.add_dependency "simple_token_authentication", "> 1.0", "< 2.0"

  s.add_development_dependency "pg"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
end
