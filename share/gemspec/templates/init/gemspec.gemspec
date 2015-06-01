# coding: utf-8

#Naming utils, git utils, and default boilerplate
require 'gemspec'

#This is a place to put custom overrides to Gemspec.boilerplate
begin; require_relative 'gemspec.rb'; rescue LoadError; end

Gem::Specification.new do |s|

  #Name is the name of the project root directory
  s.name           = Gemspec.base_dirname(__FILE__)

  Gemspec.boilerplate(s)

  #s.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."

  #####Must change
  s.summary       = %q{TODO: Write a summary}
  s.description   = %q{TODO: Write a description}
  s.licenses      = %w[GPL-2.0]


  #####Unlikely to change
  s.email         = [ `git config user.email` ]
  s.homepage      = "https://github.com/#{`git config github.username`}/#{s.name}.git"
  $? == 0 or s.homepage = nil
  ###################################

  #Dependencies
  s.add_development_dependency 'rake', '~> 10.4'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'minitest-documentation'
  s.add_development_dependency 'rspec'

end
