require 'nokogiri'
require 'pp'
require 'yaml'
require 'nokogiri'
require 'HTMLEntities'
require_relative "libeagle/xml"
require_relative "libeagle/base"
require_relative "libeagle/eagle"
require_relative "libeagle/types"
require_relative "libeagle/libeagle"

raise "LibEagle requires Ruby >= 1.8.6" if RUBY_VERSION < "1.8.6"