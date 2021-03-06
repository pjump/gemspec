# -*- coding: utf-8 -*-

#Gemspec::boilerplate
# - adds standard boilerplate to its argument (assumed to be a Gem::Specification) based on the spec's name and git-provided data
# - if they don't exist, it scaffolds basic lib files which should exist for the spec name

require 'gemspec/bootstrap_lib'
require 'gemspec/camelize'
require 'gemspec/base_dirname'
require 'gemspec/git'

module Gemspec
  module_function

  #####These settings shouldn't change as long as you follow conventions
  def boilerplate(s)

    #Naming according to conventions
    s.metadata["namespaced_path"] = s.name.tr('-', '/')
    s.metadata["constant_name"] = camelize(s.metadata["namespaced_path"])

    #Add lib to path so that the version file can be loaded
    lib = File.expand_path('lib')
    $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

    #Bootstrap the lib directory along with the basic *.rb files
    #This won't overwrite existing files
    Gemspec::bootstrap_lib!(s)

    #Get VERSION and VERSION_FOR_HUMANS from the version file
    require "#{s.metadata["namespaced_path"]}/version"
    spec_module         = Object.const_get(s.metadata["constant_name"])
    s.version        = spec_module::VERSION
    s.metadata["human_version"] = spec_module::VERSION_FOR_HUMANS

    #Specify common paths and files
    s.test_files    = Git::ls_files.grep(%r{^(test|s|features)/})
    s.files         = Git::ls_files.reject { |f| f.match(%r{^(test|s|features)/}) }
    s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
    s.require_paths = ["lib"]

    #Authors are all committers or `git config user.name` if the former is empty
    s.authors       = Git::ls_authors
  end

  memoize def current
    spec = nil
    Git.cdroot do 
      spec = Gem::Specification.load('gemspec.gemspec')
    end
    spec
  end

end
