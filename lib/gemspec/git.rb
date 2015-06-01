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

    #Go to the repo's root (and back if a block is given)

    def cdroot!(&blk)
      cdup = '.' if (cdup=`git rev-parse --show-cdup`.chomp) == ""
      if blk
        Dir.chdir cdup, &blk
      else
        Dir.chdir cdup
      end
    end

    #Go to the repo's root -- block must be given
    
    def cdroot(&blk)
      return unless blk
      cdroot! &blk
    end

    def clean?
      `git status --porcelain`.chomp == ""
    end

  end
end
