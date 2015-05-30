$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

$gemspec = Gem::Specification.load(Dir["*.gemspec"][0]) 
require $gemspec.name
