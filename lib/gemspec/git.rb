# -*- coding: utf-8 -*-

require 'memoist'
require 'super_hash'

module Gemspec
  module Git
    extend Memoist
    module_function

    memoize def ls_files
      `git ls-files -z`.split("\x0")
    end

    memoize def config
      cmd = %w[git config --list]
      config = SuperHash.new
      IO.popen(cmd).each do |line|
        line.chomp!
        path, _, value = line.partition("=")
        path = path.split(".").map(&:to_sym)
        path, assign = path[0...-1], path[-1]
        (path.reduce(config) {|acc,key| acc[key] })[assign] = value
      end
      config
    end

    memoize def ls_authors
      authors = `git log > /dev/null 2>&1 && git shortlog -sn`.split("\n").map {|a| a.sub(/^[\d\s]*/, '') }
      authors = (authors.empty? && [ `git config user.name` ]) || authors
    end

    def cdroot!
      unless (cdup=`git rev-parse --show-cdup`.chomp) == ""
        Dir.chdir cdup
      end
    end

  end
end
