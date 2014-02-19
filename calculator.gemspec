Gem::Specification.new do |s|
  s.name        = "calculator"
  s.version     = "0.0.1"
  s.authors     = ["Luis Ramalho"]
  s.email       = ["info@luisramalho.com"]

  s.summary     = "A basic non-scientific calculator"
  s.description = "This gem allows you to make simple calculations."
  s.homepage    = "https://github.com/luisramalho/calculator"
  s.license     = 'MIT'

  s.files       = Dir["lib/**/*.rb", "Rakefile", "README.md"]
  s.test_files  = Dir["spec/*.rb"]

  s.add_development_dependency 'rspec'
end
