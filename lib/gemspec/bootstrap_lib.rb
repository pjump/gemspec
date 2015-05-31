#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'yaml'
require 'erb'
require 'fileutils'

require 'memoist'

require 'gemspec/camelize'

module Gemspec
  extend Memoist

  module_function

  def bootstrap_lib!(spec)

    system('git', 'status') || system(*%w[git init .])
    config = {}
    config["constant_name"] = spec.metadata["constant_name"] || camelize(metadata["namespaced_path"])
    config["namespaced_path"] = spec.metadata["namespaced_path"] || spec.name.tr('-', '/')
    config["constant_array"] = config["constant_name"].split("::")

    path = "lib/#{config["namespaced_path"]}"
    versionfilerb = "#{path}/version.rb"
    versionfile = "#{path}/VERSION"
    human_versionfile = "#{path}/VERSION_FOR_HUMANS"
    rbfile = "#{path}.rb"

    FileUtils.mkdir_p path

    template_write(rbfile, config, templates["newgem.tt"])  unless File.exist?(rbfile)
    template_write(versionfilerb, config, templates["version.rb.tt"])  unless File.exist?(versionfilerb)
    File.write(versionfile, '0.1.0' + "\n") unless File.exist?(versionfile)
    File.write(human_versionfile, '0.1.0' + "\n") unless File.exist?(human_versionfile)
  end

  memoize def templates
    ret = nil
    File.open(__FILE__) do |this_file|
      this_file.find { |line| line =~ /^__END__ *$/ }
      ret = YAML.load(this_file.read)
    end
    return ret
  end

  def template_write(filename, config, template_str)
    File.write(filename, ERB.new(template_str, nil,'-').result(binding))
  end
end

__END__
---
newgem.tt: |
  require "<%=config["namespaced_path"]%>/version"
  <%- if config[:ext] -%>
  require "<%=config["namespaced_path"]%>/<%=config["name"]%>"
  <%- end -%>

  <%- config["constant_array"].each_with_index do |c,i| -%>
  <%= '  '*i %>module <%= c %>
  <%- end -%>
  <%= '  '*config["constant_array"].size %>
  <%- (config["constant_array"].size-1).downto(0) do |i| -%>
  <%= '  '*i %>end
  <%- end -%>
version.rb.tt: |
  <%- config["constant_array"].each_with_index do |c,i| -%>
  <%= '  '*i %>module <%= c %>
  <%- end -%>
  <%= '  '*config["constant_array"].size %>VERSION = File.read(File.expand_path("../VERSION", __FILE__)).chomp
  <%= '  '*config["constant_array"].size %>VERSION_FOR_HUMANS = File.read(File.expand_path("../VERSION_FOR_HUMANS", __FILE__)).chomp
  <%- (config["constant_array"].size-1).downto(0) do |i| -%>
  <%= '  '*i %>end
  <%- end -%>
