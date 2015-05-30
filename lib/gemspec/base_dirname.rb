# -*- coding: utf-8 -*-

require 'pathname'
module Gemspec
  module_function
  def base_dirname(file)
    Pathname.new(file).dirname.realdirpath.basename.to_s
  end
end
