module LibEagle
  class ElementClassNotFound < StandardError; end
  class Parser

    def self.initElementClass(name,xml)
      class_name = LibEagle::CLASS_NAMES[name]
      if class_name
        LibEagle::const_get(class_name).new_with_xml(xml)
      else
        raise ElementClassNotFound.new("Element: `#{name}` class wasn't found in the list of the known classes")
      end
    end

  	def self.parseFile(file)
  		content = IO.read(file)
  		parseXML(content)
  	end

    def self.parseXML(xml_content)
      xml = Nokogiri::XML(xml_content)
      root = xml.root
      eagle = initElementClass(root.name, root)
      return eagle
    end
  end
end