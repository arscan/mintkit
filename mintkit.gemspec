# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mintkit/version'

Gem::Specification.new do |spec|
  spec.name          = "mintkit"
  spec.version       = Mintkit::VERSION
  spec.authors       = ["Rob Scanlon"]
  spec.email         = ["robscanlon@gmail.com"]
  spec.description   = %q{Ruby API for mint.com. Not at all affiliated with or endorsed by  mint.com/Intuit.  Your mileage may vary.}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/arscan/mintkit"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "mechanize"
  spec.add_runtime_dependency "trollop"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
