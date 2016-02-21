# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git_timelog/version'

Gem::Specification.new do |spec|
  spec.name          = "git_timelog"
  spec.version       = GitTimelog::VERSION
  spec.authors       = ["Sushil Shrestha", "Ganesh Kunwar", "Surya Siwakoti"]
  spec.email         = ["sushil@jyaasa.com", "ganesh@jyaasa.com", "surya@jyaasa.com"]
  spec.summary       = "A tool to extract daily update from GIT commits."
  spec.description   = "The tool can return json of the tasks done along with start and end time. As well as simply copy the list of commits done as plain-text list which can be ordered or unordered."
  spec.homepage      = "http://jyaasa.com/git_timelog"
  spec.license       = "MIT"

  spec.files         = Dir.glob("{bin,lib}/**/*") + %w(LICENSE.txt README.md)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "httparty", "~> 0.13"
end
