# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'md_revelator/version'

Gem::Specification.new do |spec|
  spec.name          = "md_revelator"
  spec.version       = Md::Revelator::VERSION
  spec.authors       = ["Wei Tie"]
  spec.email         = ["nuaafe@gmail.com"]
  spec.description   = "Generated reveal.js based presentations from markdown"
  spec.summary       = "Generated reveal.js based presentations from markdown"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
