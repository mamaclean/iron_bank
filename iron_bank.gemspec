Gem::Specification.new do |s|
  s.name        = 'iron_bank'
  s.version     = '0.0.0'
  s.date        = '2014-07-11'
  s.summary     = 'Iron Bank'
  s.description = 'A simple API wrapper for debitoor'
  s.authors     = ['Enrico Genauck', 'Antonio Carpentieri']
  s.email       = 'kontakt@enricogenauck.de'
  s.files       = ['lib/iron_bank.rb']
  s.homepage    = ''
  s.license     = 'MIT'


  s.add_runtime_dependency 'httparty'
  s.add_runtime_dependency 'oauth2'
  s.add_runtime_dependency 'activesupport'

  s.add_development_dependency 'bundler', '~> 1.7'
  s.add_development_dependency 'turn'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'dotenv'
end
