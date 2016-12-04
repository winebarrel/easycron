# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easycron/version'

Gem::Specification.new do |spec|
  spec.name          = 'easycron'
  spec.version       = Easycron::VERSION
  spec.authors       = ['Genki Sugawara']
  spec.email         = ["sugawara@cookpad.com"]

  spec.summary       = %q{EasyCron API Ruby Client.}
  spec.description   = %q{EasyCron API Ruby Client.}
  spec.homepage      = 'https://github.com/winebarrel/easycron'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday'
  spec.add_dependency 'faraday_middleware'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
