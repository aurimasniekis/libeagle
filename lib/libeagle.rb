require 'nokogiri'
require 'pp'
require 'yaml'
require 'nokogiri'
require 'HTMLEntities'
require_relative "eagle/xml"
require_relative "eagle/base"
require_relative "eagle/eagle"
require_relative "eagle/types"
require_relative "eagle/libeagle"

raise "LibEagle requires Ruby >= 1.8.6" if RUBY_VERSION < "1.8.6"
