Gem::Specification.new do |s|
  s.name        = 'specstar-models'
  s.version     = '0.2.4'
  s.date        = Time.now.to_date
  s.summary     = 'RSpec helpers for models.'
  s.description = 'This gem provides RSpec matchers for model attributes and validators.'
  s.authors     = ['Sujoy Gupta']
  s.email       = 'sujoyg@gmail.com'
  s.files       = Dir["lib/**/*"] + ["MIT-LICENSE"]
  s.homepage    = 'http://github.com/sujoyg/specstar-models'
  s.license     = 'MIT'

  s.add_runtime_dependency 'rspec-core', '~> 3.1'
  s.add_runtime_dependency 'rspec-expectations', '~> 3.1'
end
