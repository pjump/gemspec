$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require Gemspec.current.name.tr('-','/')

require 'minitest/autorun'
require 'minitest/documentation'
