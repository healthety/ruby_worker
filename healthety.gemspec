# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "healthety/version"

Gem::Specification.new do |s|
  s.name        = "healthety"
  s.version     = Healthety::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = "Martin Jagusch"
  s.email       = "m@martinjagusch.com"
  s.homepage    = "https://github.com/healthety/ruby_worker"
  s.description = "Sends JSON wrapped data via UDP packets to a given host."
  s.summary     = s.description

  s.add_dependency("json", "~> 1.5.1")
  s.add_development_dependency("rspec", "~> 2.5.0")
  s.add_development_dependency("mocha", "~> 0.9.12")
  s.add_dependency("daemons", "~> 1.1.3")

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ["lib"]
end
