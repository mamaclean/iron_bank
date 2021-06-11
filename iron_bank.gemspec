Gem::Specification.new do |s|
  s.name        = 'iron_bank'
  s.version     = '0.0.3'
  s.date        = '2021-06-11'
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

  s.add_development_dependency 'bundler', '2.0.1'
  s.add_development_dependency 'rake'
end
