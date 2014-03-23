Gem::Specification.new do |s|
  s.name        = 'counterfeiter'
  s.version     = '0.0.0'
  s.date        = '2014-03-24'
  s.summary     = "counterfeiting files"
  s.description = "Scalable solution to synchronize files across multiple servers"
  s.authors     = ["Julien Pellet"]
  s.email       = 'jp@julienpellet.com'
  s.files       = ["lib/counterfeiter.rb"]
  s.add_runtime_dependency 'redis', '~> 3.0'
  s.executables << 'counterfeit'
  s.homepage    = 'https://github.com/jp/counterfeiter'
  s.license       = 'MIT'
end
