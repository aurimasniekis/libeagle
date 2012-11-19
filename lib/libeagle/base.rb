module Eagle
	class Base
		def self.attribute(*args)
			
			instance_name = args.first
			params = args.last

			if params[:default]
				instance_variable_set("@#{instance_name}",params[:default]) unless instance_variable_defined?("@#{instance_name}")
				define_method instance_name.to_sym do
					instance_variable_set("@#{instance_name}",params[:default]) unless instance_variable_defined?("@#{instance_name}")
					instance_variable_get("@#{instance_name}")
				end
			else 
				define_method instance_name.to_sym do
					instance_variable_get("@#{instance_name}")
				end
			end

			define_method "#{instance_name}=".to_sym do |value|
      	instance_variable_set("@#{instance_name}",value)
    	end

    	if params[:required]
    		@@required_attribute ||= Array.new
    		@@required_attribute << instance_name
    	end

    	@@atributes ||= Array.new
    	@@atributes << instance_name
			
		end

		def valid?
			@@required_attribute.each do |attribute|
				unless send "#{attribute}"
					puts "#{attribute} is required"
				end
			end
		end
	
		def self.newXML(xml)
			new
			@@atributes.each do |attribute|
				attribute = attribute.to_s
				if xml[attribute]
					instance_variable_set("@#{attribute}",xml[attribute])
				end
			end
			self
		end
		

	end
end

class Test < Eagle::Base
	attribute :version, :default => "6.3", :required => true
	attribute :name, :default => "6.3", :required => true
end

xml = Hash.new
xml['name'] = "Tom"

a = Test.newXML(xml)
p a.name
a.valid?