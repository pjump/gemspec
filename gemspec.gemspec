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
  s.summary       = %q{Gemspec aims to streamline and DRY up the creation of ruby packages AKA gems}
  s.description   = File.open('README.md').gets('.')
  s.licenses      = %w[GPL-2.0]

  #s.files += Dir["share/gemspec/templates/**"]
  s.files << "share/gemspec/templates/init/Gemfile"

  #####Unlikely to change
  s.email         = [ `git config user.email`.chomp ]
  s.homepage      = "https://github.com/#{`git config github.username`.chomp}/#{s.name}.git"
  $? == 0 or s.homepage = nil
  ###################################

  s.add_dependency 'activesupport', '4.2.1'
  s.add_dependency 'memoist', '0.12.0'
  s.add_dependency 'rake', '~> 10.4'

end
