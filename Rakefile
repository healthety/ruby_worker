require "rake/testtask"

Rake::TestTask.new(:spec) do |spec|
  spec.libs << "lib" << "spec"
  spec.pattern = "spec/**/*_spec.rb"
  spec.verbose = true
end

task :default => :spec
