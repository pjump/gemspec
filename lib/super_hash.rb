#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# SuperHash is very much like OpenStruct except that it creates whole paths instead of just keys
#SuperHash is a hash whose default value defaults to another instance of SuperHash
#which allows for chaining:
#   super_hash[:x][:y][:z] will create the :x, :y, and :z sub-superhashes
#Assignment creates signleton accessor methods
#   super_hash[:x] = 42
#   super_hash.respond_to? :x == true
#   super_hash.respond_to? :x= == true
#Since a bare:
#   super_hash[:x]
#*assigns* another superhash if no :x key is found, this alone results in:
#   super_hash.respond_to?(:x) == true
#   super_hash.respond_to?(:x=) == true
#method_missing delegates to either :[] or :[]= (depeding on whether the method name ends with =)
#so either eventually results in a singleton method definition and you can use dots instead
#of [] like in JavaScript
#   super_hash.x.y.z = 42 #This creates the whole chain of hashes and the accessor methods

class SuperHash < Hash
  def initialize(*args)
    super(*args) { |hash,key|
      hash[key] = SuperHash.new
    }
  end
  #Assignment defines accessor methods
  def []=(key, val)
    this = self
    unless respond_to?(key)
      self.define_singleton_method(key) do
        this[key]
      end
    end
    unless respond_to?("#{key}=".to_sym)
      self.define_singleton_method("#{key}=".to_sym) do |v|
        this[key] = v
      end
    end
    return super(key, val)
  end

  def method_missing(key, *args)
    if /=$/ === key
      key = key.to_s.sub(/=$/,'').to_sym
      return public_send :[]=, key, *args
    end
    return  public_send :[], key, *args
  end
end
