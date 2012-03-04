Gem::Specification.new do |s|
  s.name        = 'hasherizer'
  s.version     = '0.0.2'
  s.date        = '2012-02-26'
  s.summary     = "Recursively convert object's instance variables to a flat hash."
  s.description = "Extract instance variables names and values into a flat hash no matter how many levels deep your objects are."
  s.authors     = ["Pepe Hipolito"]
  s.email       = 'pepe.hipolito@gmail.com'
  s.files       = Dir.glob("lib/**/*.rb")
  # s.homepage    = 'http://rubygems.org/gems/hasherizer'
end
