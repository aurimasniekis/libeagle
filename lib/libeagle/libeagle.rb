require_relative "base"
require_relative "eagle"
require 'yaml'
require 'nokogiri'
require 'HTMLEntities'
raise "LibEagle requires Ruby >= 1.8.6" if RUBY_VERSION < "1.8.6"

module LibEagle
  class Parser
    def self.parse(file)
      xml = Nokogiri::XML(IO.read(file))
      root = xml.xpath('//eagle').first
      eagle = Eagle.newXML(root)
      return eagle.saveXML
    end
  end
  
end

puts LibEagle::Parser.parse('./test.xml')
