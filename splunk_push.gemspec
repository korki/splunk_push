# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'splunk_push'
  spec.version       = '0.0.1'
  spec.authors       = ['Orest Hrycyna']
  spec.email         = ['orest.hrycyna@gmail.com']
  spec.summary       = %q{Splunk Push}
  spec.description   = %q{Splunk Push}
  spec.homepage      = 'https://github.com/korki/splunk_push'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = []
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
