$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

gem_name = File.basename(File.expand_path('../..', __FILE__))
require gem_name
