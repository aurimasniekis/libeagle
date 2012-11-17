require_relative "eagle"
raise "LibEagle requires Ruby >= 1.8.6" if RUBY_VERSION < "1.8.6"

module LibEagle

	def parse(file)
		xml = Nokogiri::XML(IO.read(file))
		root = xml.xpath('//eagle').first
		eagle = Eagle.new(root)
	end
	
end
