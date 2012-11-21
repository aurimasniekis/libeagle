module LibEagle
  class XML

    attr_accessor :htmlentities,
                  :output,
                  :lib_eagle_objects,
                  :values


    XML_DECLARATION = %(<?xml version="1.0" encoding="utf-8"?>\n<!DOCTYPE eagle SYSTEM "eagle.dtd">\n)

    def rname(name)
      name.gsub(/^clazz$/, "class")
    end

    def initialize(lib_eagle_objects,values)
      @output = ""
      @lib_eagle_objects = lib_eagle_objects
      @values = values
      @htmlentities = HTMLEntities.new
    end

    def tag_name
      if @lib_eagle_objects[:element_name]
        return @values.element_name
      else
        return @values.class.name.split("::").last.downcase
      end
    end

    def empty_tag
      xml = "<#{tag_name}"
      @lib_eagle_objects[:attributes].each_pair do|attribute, params|
        attribute = rname(attribute)
        if @values.instance_variable_get("@attribute_#{attribute}")
          value = @values.instance_variable_get("@attribute_#{attribute}")
          xml << " #{attribute}=\"#{value}\""
        end
      end
      xml << "/>\n"
      @output << xml
    end

    def open_tag
      xml = "<#{tag_name}"
      @lib_eagle_objects[:attributes].each_pair do|attribute, params|
        attribute = rname(attribute)
        if @values.instance_variable_get("@attribute_#{attribute}")
          value = @values.instance_variable_get("@attribute_#{attribute}")
          xml << " #{attribute}=\"#{value}\""
        end
      end
      xml << ">\n"
      @output << xml
    end

    def open_tag_content
      xml = "<#{tag_name}"
      @lib_eagle_objects[:attributes].each_pair do|attribute, params|
        attribute = rname(attribute)
        if @values.instance_variable_get("@attribute_#{attribute}")
          value = @values.instance_variable_get("@attribute_#{attribute}")
          xml << " #{attribute}=\"#{value}\""
        end
      end
      xml << ">"
      @output << xml
    end

    def close_tag
      @output << "</#{tag_name}>\n"
    end

    def content
      @output << @htmlentities.encode(@values.content)
    end

    def objects
      xml = ""
      @lib_eagle_objects[:objects].each_pair do |object, params|
        object = rname(object)
        objects = @values.instance_variable_get("@object_#{object}")
        if objects.is_a? Array
          objects.each do |obj|
            xml << obj.saveXML
          end
        elsif objects != nil
          xml << objects.saveXML
        end
      end
      @output << xml
    end

    def parse
      if @lib_eagle_objects[:root_element]
        @output << XML_DECLARATION
      end
      if @lib_eagle_objects[:empty_element]
        empty_tag
      elsif @lib_eagle_objects[:text_content]
        open_tag_content
        content
        close_tag
      else
        open_tag
        objects
        close_tag
      end
      @output
    end
  end
end