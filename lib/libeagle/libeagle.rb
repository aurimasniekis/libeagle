require_relative "eagle"
require 'yaml'
require 'nokogiri'
raise "LibEagle requires Ruby >= 1.8.6" if RUBY_VERSION < "1.8.6"

module LibEagle
  class Parser
    def self.parse(file)
      xml = Nokogiri::XML(IO.read(file))
      root = xml.xpath('//eagle').first
      eagle = Eagle.new(root)
      return eagle
    end
  end
  
end

puts LibEagle::Parser.parse('./test.xml').to_yaml
