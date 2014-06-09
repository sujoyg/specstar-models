Gem::Specification.new do |s|
  s.name        = 'specstar-models'
  s.version     = '0.2.0'
  s.date        = Time.now.to_date
  s.summary     = 'RSpec helpers for models.'
  s.authors     = ['Sujoy Gupta']
  s.email       = 'sujoyg@gmail.com'
  s.files       = ['lib/specstar/models.rb']
  s.homepage    = 'http://github.com/sujoyg/specstar-models'
  s.license     = 'MIT'

  s.add_runtime_dependency 'rspec-core'
  s.add_runtime_dependency 'rspec-expectations'
end
