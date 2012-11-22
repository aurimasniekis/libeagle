require_relative "xml"
require_relative "base"
require_relative "eagle"
require_relative "types"
require 'pp'
require 'yaml'
require 'nokogiri'
require 'HTMLEntities'
raise "LibEagle requires Ruby >= 1.8.6" if RUBY_VERSION < "1.8.6"

module LibEagle
  class Parser
    def self.parseXML(xml_content)
      xml = Nokogiri::XML(xml_content)
      root = xml.xpath('//eagle').first
      eagle = Eagle.newXML(root)
      return eagle
    end
  end
  
end

xml = LibEagle::Parser.parseXML(IO.read('./schematic.sch'))
puts xml.saveXML