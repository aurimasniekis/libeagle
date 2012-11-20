module LibEagle
  class AttributeRequired < StandardError; end
  class AttributeValueInvalid < StandardError; end
  class Base

    def self.eagle_attributes
      @eagle_attributes ||= Hash.new
    end

    def self.eagle_objects
      @eagle_objects ||= Hash.new
    end

    def self.end_tag
      @end_tag ||= false
    end

    def self.root
      @root ||= false
    end

    def self.eagle_content
      @eagle_content ||= false
    end

    def self.eagle_class
      @eagle_class ||= false
    end

    def self.has_content
      @eagle_content = true
      define_method "content".to_sym do
        instance_variable_get("@content")
      end

      define_method "content=".to_sym do |value|
        instance_variable_set("@content",value)
      end
    end

    def self.object(*args)
      object_name = args.first.to_s
      if args.size > 1
        params = args.last
      end

      eagle_objects[object_name] ||= Hash.new

      eagle_objects[object_name][:class] = params[:class] if params && params[:class]
      eagle_objects[object_name][:class] = object_name.capitalize unless params && params[:class]

      define_method object_name.to_sym do
        instance_variable_get("@#{object_name}")
      end

      define_method "#{object_name}=".to_sym do |value|
        instance_variable_set("@#{object_name}",value)
      end
    end

    def self.attribute(*args)
      attribute_name = args.first.to_s
      if args.size > 1
        params = args.last
      end

      eagle_attributes[attribute_name] ||= Hash.new
      eagle_attributes[attribute_name][:required] = true if params && params[:required]
      eagle_attributes[attribute_name][:valid_values] = params[:valid_values] if params && params[:valid_values]

      if params && params[:default]
        define_method attribute_name.to_sym do
          instance_variable_set("@#{attribute_name}",params[:default]) unless instance_variable_defined?("@#{attribute_name}")
          instance_variable_get("@#{attribute_name}")
        end
      else 
        define_method attribute_name.to_sym do
          instance_variable_get("@#{attribute_name}")
        end
      end

      define_method "#{attribute_name}=".to_sym do |value|
        instance_variable_set("@#{attribute_name}",value)
      end
    end

    def self.no_end_tag
      @end_tag = true
    end

    def self.is_root
      @root = true
    end

    def self.has_class_name(arg)
      @eagle_class = true
      @base.instance_variable_set("@class_name", arg.downcase)
    end

    def self.newXML(xml)
      @base = self.new
      if @eagle_content
        @base.instance_variable_set("@content",xml.content)
      end
      if @eagle_attributes
        @eagle_attributes.each_key do |attribute|
          @base.instance_variable_set("@#{attribute}",xml[attribute]) if xml[attribute]
        end
      end

      if @eagle_objects
        @eagle_objects.each_pair do |object, params|
          if xml.xpath(object).size > 1
            objects = []
            xml.xpath(object).each do |node|
              objects << Object::const_get(params[:class]).newXML(node)
            end
            @base.instance_variable_set("@#{object}",objects)
          elsif xml.xpath(object).size == 1
            xml_node = xml.xpath(object).first
            @base.instance_variable_set("@#{object}",Object::const_get(params[:class]).newXML(xml_node))
          end
        end
      end
      @base
    end

    def saveXML
      coder = HTMLEntities.new
      if is_valid?
        output = ""
        if self.class.root
          output << %(<?xml version="1.0" encoding="utf-8"?>\n<!DOCTYPE eagle SYSTEM "eagle.dtd">\n)
        end
        if self.class.eagle_class
          class_name = @base.instance_variable_get("@class_name")
        else
          class_name = self.class.name.downcase
        end
        output << "<#{class_name}"
        self.class.eagle_attributes.each_pair do |attribute, value|
          var = self.instance_variable_get("@#{attribute}")
          var = coder.encode(var) if var
          output << " #{attribute}=\"#{var}\"" if var
        end
        if self.class.end_tag
          output << "/>\n"
        else
          output << ">\n"
          self.class.eagle_objects.each_pair do |object, params|
            objects = self.instance_variable_get("@#{object}")
            if objects.is_a? Array
              objects.each do |obj|
                output << obj.saveXML
              end
            elsif objects != nil
              output << objects.saveXML
            end
          end
          if self.class.eagle_content
            output << coder.encode(@content)
          end
          output << "</#{class_name}>\n"
        end
        output
      else
        return false
      end
    end


    def is_valid?
      self.class.eagle_attributes.each_pair do |attribute, params|
        if params[:required]
          unless send "#{attribute}"
            raise AttributeRequired.new("#{self.class.name}: #{attribute} is required")
            return false
          end
        end

        if params[:valid_values]
          value = send "#{attribute}"
          is_valid = params[:valid_values].detect do |valid_value|
            Regexp.new("^#{valid_value}$") =~ value
          end
          unless is_valid
             raise AttributeValueInvalid.new("`#{attribute}` value: \"#{value}\" isn't in valid range (#{params[:valid_values]})")
             return false
          end
        end
        return true
      end
    end
  end
end