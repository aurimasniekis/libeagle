module LibEagle
  class Parser

  	def self.parseFile(file)
  		content = IO.read(file)
  		parseXML(content)
  	end

    def self.parseXML(xml_content)
      xml = Nokogiri::XML(xml_content)
      root = xml.xpath('//eagle').first
      eagle = Eagle.newXML(root)
      return eagle
    end
  end
end