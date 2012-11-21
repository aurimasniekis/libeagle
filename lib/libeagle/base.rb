module LibEagle
  class AttributeRequired < StandardError; end
  class AttributeValueInvalid < StandardError; end
  class Base

    def self.parse_params(params)
      if params.size > 0
        return params.first
      else
        return nil
      end
    end

    

    def self.iname(name)
      name.gsub(/^class$/, "clazz")
    end

    #
    # Getter of LibEagle objects
    def self.lib_eagle_objects
      @lib_eagle_objects ||= Hash.new
      @lib_eagle_objects[:attributes] ||= {}
      @lib_eagle_objects[:objects] ||= {}
      @lib_eagle_objects[:empty_element] ||= false
      @lib_eagle_objects[:root_element] ||= false
      @lib_eagle_objects[:text_content] ||= false
      @lib_eagle_objects[:element_name] ||= false
      @lib_eagle_objects
    end

    def self.empty_element
      lib_eagle_objects[:empty_element] = true
    end

    def self.root_element
      lib_eagle_objects[:root_element] = true
    end

    def self.text_content
      lib_eagle_objects[:text_content] = true

      # Define Setter and getter
      attr_accessor :content
    end

    def self.change_element_name(element_name)
      lib_eagle_objects[:element_name] = true
      define_method "element_name".to_sym do
          instance_variable_set("@element_name", element_name) unless instance_variable_defined?("@element_name")
          instance_variable_get("@element_name")
        end
    end


    def self.attribute(attribute_name, *params)
      attribute_name = attribute_name.to_s
      variable_name = "@attribute_#{attribute_name}"
      params = parse_params(params)

      # Initialize place inside LibEagle objects
      lib_eagle_objects[:attributes][attribute_name] ||= {}
      lib_eagle_objects[:attributes][attribute_name][:required] = true if params && params[:required]
      lib_eagle_objects[:attributes][attribute_name][:valid_values] = params[:valid_values] if params && params[:valid_values]

      # If default value is set return default value
      if params&& params[:default]
        define_method "attribute_#{attribute_name}".to_sym do
          instance_variable_set(variable_name, params[:default]) unless instance_variable_defined?(variable_name)
          instance_variable_get(variable_name)
        end
      else
        define_method "attribute_#{attribute_name}".to_sym do
          instance_variable_get(variable_name)
        end
      end

      # Attribute setter
      define_method "attribute_#{attribute_name}=".to_sym do |value|
        instance_variable_set(variable_name,value)
      end
    end

    def self.object(object_name, *params)
      object_name = object_name.to_s
      variable_name = "@object_#{object_name}"
      params = parse_params(params)

      # Initialize place inside LibEagle objects
      lib_eagle_objects[:objects][object_name] ||= {}
      lib_eagle_objects[:objects][object_name][:class] = params[:class] if params && params[:class]
      lib_eagle_objects[:objects][object_name][:class] = object_name.capitalize unless params && params[:class]

      # Object getter
      define_method "object_#{object_name}".to_sym do
        instance_variable_get(variable_name)
      end

      # Object setter
      define_method "object_#{object_name}=".to_sym do |value|
        instance_variable_set(variable_name,value)
      end
    end

    def self.newXML(xml)
      @base_class = self.new

      if @lib_eagle_objects[:text_content]
        @base_class.instance_variable_set("@content", xml.content)
      end

      if @lib_eagle_objects[:attributes].size > 0
        @lib_eagle_objects[:attributes].each_pair do |attribute_name, params|
          @base_class.instance_variable_set("@attribute_#{attribute_name}",xml[attribute_name]) if xml[attribute_name]
        end
      end

      if @lib_eagle_objects[:objects].size > 0
        @lib_eagle_objects[:objects].each_pair do |object_name, params|
          if xml.xpath(object_name).size > 1
            objects = []
            xml.xpath(object_name).each do |xml_node|
              objects << LibEagle::const_get(params[:class]).newXML(xml_node)
            end
            @base_class.instance_variable_set("@object_#{object_name}",objects)
          elsif xml.xpath(object_name).size == 1
            xml_node = xml.xpath(object_name).first
            object = LibEagle::const_get(params[:class]).newXML(xml_node)
            @base_class.instance_variable_set("@object_#{object_name}",object)
          end
        end
      end

      return @base_class
    end

    def is_valid?
      self.class.lib_eagle_objects[:attributes].each_pair do |attribute, params|
        if params[:required]
          unless self.instance_variable_get("@attribute_#{attribute}")
            raise AttributeRequired.new("#{self.class.name}: #{attribute} is required")
            return false
          end
        end
        return true
      end
    end

    def saveXML
      if is_valid?
        LibEagle::XML.new(self.class.lib_eagle_objects,self).parse
      end
    end

  end
end