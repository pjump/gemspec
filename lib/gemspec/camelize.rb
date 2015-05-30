# -*- coding: utf-8 -*-

require 'forwardable'
require 'active_support/inflector/methods'

module Gemspec
  module CamelizeMethod
    extend Forwardable
    def_delegators ::ActiveSupport::Inflector, :camelize
  end
  extend CamelizeMethod
end

