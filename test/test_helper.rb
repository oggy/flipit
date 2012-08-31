require 'bundler'
require 'minitest/spec'
require 'debugger'

ROOT = File.expand_path('..', File.dirname(__FILE__))
$:.unshift "#{ROOT}/lib"
require 'flipit'
