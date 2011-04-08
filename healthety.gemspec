# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "healthety/version"

Gem::Specification.new do |s|
  s.name        = "healthety"
  s.version     = Healthety::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = "Martin Jagusch"
  s.email       = "m@martinjagusch.com"
  s.homepage    = ""
  s.summary     = %q{}
  s.description = %q{Healthety reporter}

  s.add_development_dependency("rspec", "~> 2.5.0")
  s.add_development_dependency("mocha")

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ["lib"]
end
