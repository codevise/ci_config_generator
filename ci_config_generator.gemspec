# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ci_config_generator/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tim Fischbach"]
  gem.email         = ["tfischbach@codevise.de"]
  gem.description   = %q{Generate config files for continious integration.}
  gem.summary       = %q{Generate config files for continious integration from templates inside the repository.}
  gem.homepage      = "http://github.com/codevise/ci_config_generator"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ci_config_generator"
  gem.require_paths = ["lib"]
  gem.version       = CiConfigGenerator::VERSION

  gem.add_development_dependency 'rspec', '~> 2.11'
end
