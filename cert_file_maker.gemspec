# -*- encoding: utf-8 -*-
require_relative 'lib/version'

Gem::Specification.new do |s|
  s.platform        = Gem::Platform::RUBY
  s.name            = 'cert_file_maker'
  s.version         = CertFileMaker::VERSION
  s.summary         = 'Generate certification file'
  s.description     = 'Railties app to generate certification files'

  s.license         = 'MIT'

  s.author          = 'Bernardo Galindo'
  s.email           = 'bernardo466@gmail.com'

  s.files           = ['lib/cert_file_maker.rb']
  s.require_paths   = ['lib']
end
