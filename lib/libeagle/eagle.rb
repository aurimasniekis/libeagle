  class Eagle
    attr_accessor :compatibility,
                  :drawing,
                  :version

    def initialize(xml)
      if root = xml.xpath('/eagle').first
        @version = root['version']
        if children = root.xpath('compatibility/note').first
          @compatibility = Compatibility.new(children)
        end

        if children = root.xpath('drawing').first
          @drawing = Drawing.new(children)
        end
      end
    end

  end

  class Compatibility
    attr_accessor :note

    def initialize(xml)
      @note = Note.new
      @note.note = xml.content
      @note.version = xml['version']
      @note.severity = xml['severity']
    end

  end

  class Note
    attr_accessor :note,
                  :version,
                  :severity
  end

  class Drawing
    attr_accessor :settings,
                  :grid,
                  :layers,
                  :library,
                  :schematic,
                  :board
    def initialize(xml)
      if xml.xpath('settings/setting').size > 0
        settings = xml.xpath('settings/setting')
        @settings = Settings.new(settings)
      end

      if grid = xml.xpath('grid').first
        @grid = Grid.new(grid)
      end

      if xml.xpath('layers/layer').size > 0
        layers = xml.xpath('layers/layer')
        #@layers = Layers.new(layers)
      end

      if library = xml.xpath('library').first
        @library = Library.new(library)
      end

      if schematic = xml.xpath('schematic').first
        @schematic = Schematic.new(schematic)
      end

      if board = xml.xpath('board').first
        @board = Board.new(board)
      end
    end
  end

  

  class Library
    attr_accessor :description,
                  :packages,
                  :symbols,
                  :devicesets,
                  :name

    def initialize(xml)
      @name = xml['name']
      if description = xml.xpath('description').first
        #@description = Description.new(description)
      end

      if xml.xpath('packages/package').size > 0
        packages = xml.xpath('packages/package')
        @packages = Packages.new(packages)
      end

      if xml.xpath('symbols/symbol').size > 0
        symbols = xml.xpath('symbols/symbol')
        @symbols = Symbols.new(symbols)
      end

      if xml.xpath('devicesets/deviceset').size > 0
        devicesets = xml.xpath('devicesets')
        #@devicesets = Devicesets.new(devicesets)
      end

    end

  end

  class Description
    attr_accessor :language,
                  :description

    def initialize(xml)
      @language = xml['language']
      @description = xml.content
    end
  end


  class Schematic
    attr_accessor :description,
                  :libraries,
                  :attributes,
                  :variantdefs,
                  :classes,
                  :parts,
                  :sheets,
                  :errors,
                  :xreflabel,
                  :xrefpart
  end

  class Board
    attr_accessor :description,
                  :plain,
                  :libraries,
                  :attributes,
                  :variantdefs,
                  :classes,
                  :designrules,
                  :autorouter,
                  :elements,
                  :signals,
                  :errors
  end

  class Settings
    attr_accessor :alwaysvectorfont,
                  :verticaltext
    def initialize(xml)
      xml.each do |s|
        @alwaysvectorfont = s['alwaysvectorfont'] if s['alwaysvectorfont']
        @verticaltext = s['verticaltext'] if s['verticaltext']
      end
    end
  end

  class Layers
    attr_accessor :layers

    def initialize(xml)
      @layers = []
      xml.each do |l|
        @layers << Layer.new(l)
      end
    end
  end

  class Layer
    attr_accessor :number,
                  :name,
                  :color,
                  :fill,
                  :visible,
                  :active
    
    def initialize(xml)
      @number = xml['number']
      @name = xml['name']
      @color = xml['color']
      @fill = xml['fill']
      @visible = xml['visible']
      @active = xml['active']
    end
  end

  class Grid
    attr_accessor :distance,
                  :unitdist,
                  :unit,
                  :style,
                  :multiple,
                  :display,
                  :altdistance,
                  :altunitdist,
                  :altunit

    def initialize(xml)
      @distance = xml['distance']
      @unitdist = xml['unitdist']
      @unit = xml['unit']
      @style = xml['style']
      @multiple = xml['multiple']
      @display = xml['display']
      @altdistance = xml['altdistance']
      @altunitdist = xml['altunitdist']
      @altunit = xml['altunit']
    end
  end

  class Packages
    attr_accessor :packages

    def initialize(xml)
      @packages = []
      xml.each do |p|
        @packages << Package.new(p)
      end
    end
  end

  class Symbols
    attr_accessor :symbols

    def initialize(xml)
      @symbols = []
      xml.each do |p|
        @symbols << SSymbol.new(p)
      end
    end
  end

  class Devicesets
    attr_accessor :devicesets

    def initialize(xml)
      @devicesets = []
      xml.each do |p|
        @devicesets << Deviceset.new(p)
      end
    end 
  end

  class Sheet
    attr_accessor :description,
                  :plain,
                  :instances,
                  :busses,
                  :nets
  end

  class Package
    attr_accessor :description,
                  :polygon,
                  :wire,
                  :text,
                  :circle,
                  :rectangle,
                  :frame,
                  :hole,
                  :pad,
                  :smd,
                  :name

    def initialize(xml)
      @name = xml['name']
      if description = xml.xpath('description').first
        @description = Description.new(description)
      end
      if xml.xpath('polygon').size > 0  
        @polygon = []
        xml.xpath('polygon').each do |polygon|
          @polygon << Polygon.new(polygon)
        end
      end

      if xml.xpath('wire').size > 0
        @wire = []
        xml.xpath('wire').each do |wire|
          @wire << Wire.new(wire)
        end
      end

      if xml.xpath('text').size > 0
        @text = []
        xml.xpath('text').each do |text|
          @text << Text.new(text)
        end
      end

      if xml.xpath('circle').size > 0
        @circle = []
        xml.xpath('circle').each do |circle|
          @circle << Circle.new(circle)
        end
      end

      if xml.xpath('rectangle').size > 0
        @rectangle = []
        xml.xpath('rectangle').each do |rectangle|
          @rectangle << Rectangle.new(rectangle)
        end
      end

      if xml.xpath('frame').size > 0
        @frame = []
        xml.xpath('frame').each do |frame|
          @frame << Frame.new(frame)
        end
      end

      if xml.xpath('hole').size > 0
        @hole = []
        xml.xpath('hole').each do |hole|
          @hole << Hole.new(hole)
        end
      end

      if xml.xpath('pad').size > 0
        @pad = []
        xml.xpath('pad').each do |pad|
          @pad << Pad.new(pad)
        end
      end

      if xml.xpath('smd').size > 0
        @smd = []
        xml.xpath('smd').each do |smd|
          @smd << Smd.new(smd)
        end
      end
    end
  end

  class SSymbol
    attr_accessor :description,
                  :polygon,
                  :wire,
                  :text,
                  :pin,
                  :circle,
                  :rectangle,
                  :frame,
                  :name

    def initialize(xml)
      @name = xml['name']
      if description = xml.xpath('description').first
        @description = Description.new(description)
      end
      if xml.xpath('polygon').size > 0  
        @polygon = []
        xml.xpath('polygon').each do |polygon|
          @polygon << Polygon.new(polygon)
        end
      end

      if xml.xpath('wire').size > 0
        @wire = []
        xml.xpath('wire').each do |wire|
          @wire << Wire.new(wire)
        end
      end

      if xml.xpath('text').size > 0
        @text = []
        xml.xpath('text').each do |text|
          @text << Text.new(text)
        end
      end

      if xml.xpath('pin').size > 0
        @pin = []
        xml.xpath('pin').each do |pin|
          @pin << Pin.new(pin)
        end
      end

      if xml.xpath('circle').size > 0
        @circle = []
        xml.xpath('circle').each do |circle|
          @circle << Circle.new(circle)
        end
      end

      if xml.xpath('rectangle').size > 0
        @rectangle = []
        xml.xpath('rectangle').each do |rectangle|
          @rectangle << Rectangle.new(rectangle)
        end
      end

      if xml.xpath('frame').size > 0
        @frame = []
        xml.xpath('frame').each do |frame|
          @frame << Frame.new(frame)
        end
      end
    end
  end

  class Deviceset
    attr_accessor :description,
                  :gates,
                  :devices,
                  :name,
                  :prefix,
                  :uservalue
  end

  class Device
    attr_accessor :connects,
                  :technologies,
                  :name,
                  :package
  end

  class Bus
    attr_accessor :segment,
                  :name
  end

  class Net
    attr_accessor :segment,
                  :name,
                  :class
  end

  class Segment
    attr_accessor :pinref,
                  :wire,
                  :junction,
                  :label
  end

  class SSignal

  end

  class VariantDef
    attr_accessor :name,
                  :current
  end

  class Variant
    attr_accessor :name,
                  :populate,
                  :value,
                  :technology
  end                 

  class Gate
    attr_accessor :name,
                  :symbol,
                  :x,
                  :y,
                  :addlevel,
                  :swaplevel
  end

  

  class Dimension
    attr_accessor :x1,
                  :y2,
                  :x2,
                  :y2,
                  :x3,
                  :y3,
                  :layer,
                  :dtype,
  end

  class Text
    attr_accessor :x,
                  :y,
                  :size,
                  :layer,
                  :font,
                  :ratio,
                  :rot,
                  :align,
                  :distance,
                  :text

    def initialize(xml)
      @x = xml['x']
      @y = xml['y']
      @size = xml['size']
      @layer = xml['layer']
      @font = xml['font']
      @ratio = xml['ratio']
      @rot = xml['rot']
      @align = xml['align']
      @distance = xml['distance']
      @text = xml.content
    end
  end

  class Circle
    attr_accessor :x,
                  :y,
                  :radius,
                  :width,
                  :layer

    def initialize(xml)
      @x = xml['x']
      @y = xml['y']
      @radius = xml['radius']
      @width = xml['width']
      @layer = xml['layer']
    end
  end
      
  class Rectangle
    attr_accessor :x1,
                  :y1,
                  :x2,
                  :y2,
                  :layer,
                  :rot

    def initialize(xml)
      @x1 = xml['x1']
      @y1 = xml['y1']
      @x2 = xml['x2']
      @y2 = xml['y2']
      @layer = xml['layer']
      @rot = xml['rot']
    end
  end 

  class Frame
    attr_accessor :x1,
                  :y2,
                  :x2,
                  :y2,
                  :columns,
                  :rows,
                  :layer,
                  :border_left,
                  :border_top,
                  :border_right,
                  :border_bottom

    def initialize(xml)
      @x1 = xml['x1']
      @y2 = xml['y2']
      @x2 = xml['x2']
      @y2 = xml['y2']
      @columns = xml['columns']
      @rows = xml['rows']
      @layer = xml['layer']
      @border_left = xml['border_left']
      @border_top = xml['border_top']
      @border_right = xml['border_right']
      @border_bottom = xml['border_bottom']
    end
  end

  class Hole
    attr_accessor :x,
                  :y,
                  :drill

    def initialize(xml)
      @x = xml['x']
      @y = xml['y']
      @drill = xml['drill']
    end
  end       

  class Pad
    attr_accessor :name,
                  :x,
                  :y,
                  :drill,
                  :diameter,
                  :shape,
                  :rot,
                  :stop,
                  :thermals,
                  :first

    def initialize(xml)
      @name = xml['name']
      @x = xml['x']
      @y = xml['y']
      @drill = xml['drill']
      @diameter = xml['diameter']
      @shape = xml['shape']
      @rot = xml['rot']
      @stop = xml['stop']
      @thermals = xml['thermals']
      @first = xml['first']
    end
  end

  class Smd
    attr_accessor :name,
                  :x,
                  :y,
                  :dx,
                  :dy,
                  :layer,
                  :roundness,
                  :rot,
                  :stop,
                  :thermals,
                  :cream

    def initialize(xml)
      @name = xml['name']
      @x = xml['x']
      @y = xml['y']
      @dx = xml['dx']
      @dy = xml['dy']
      @layer = xml['layer']
      @roundness = xml['roundness']
      @rot = xml['rot']
      @stop = xml['stop']
      @thermals = xml['thermals']
      @cream = xml['cream']
    end
  end

  class Pin
    attr_accessor :name,
                  :x,
                  :y,
                  :visible,
                  :length,
                  :direction,
                  :function,
                  :swaplevel,
                  :rot

    def initialize(xml)
      @name = xml['name']
      @x = xml['x']
      @y = xml['y']
      @visible = xml['visible']
      @length = xml['length']
      @direction = xml['direction']
      @function = xml['function']
      @swaplevel = xml['swaplevel']
      @rot = xml['rot']
    end
  end

  class Wire
    attr_accessor :x1,
                  :y1,
                  :x2,
                  :y2,
                  :width,
                  :layer,
                  :extent,
                  :style,
                  :curve,
                  :cap

    def initialize(xml)
      @x1 = xml['x1']
      @y1 = xml['y1']
      @x2 = xml['x2']
      @y2 = xml['y2']
      @width = xml['width']
      @layer = xml['layer']
      @extent = xml['extent']
      @style = xml['style']
      @curve = xml['curve']
      @cap = xml['cap']
    end
  end

  class Polygon
    attr_accessor :vertex,
                  :width,
                  :layer,
                  :spacing,
                  :pour,
                  :isolate,
                  :orphans,
                  :thermals,
                  :rank

    def initialize(xml)
      if xml.xpath('vertex').size > 0
        @vertex = []
        xml.xpath('vertex').each do |vertex|
          @vertex << Vertex.new(vertex)
        end
      end

      @width = xml['width']
      @layer = xml['layer']
      @spacing = xml['spacing']
      @pour = xml['pour']
      @isolate = xml['isolate']
      @orphans = xml['orphans']
      @thermals = xml['thermals']
      @rank = xml['rank']
    end
  end

  class Vertex
    attr_accessor :x,
                  :y,
                  :curve

    def initialize(xml)
      @x = xml['x']
      @y = xml['y']
      @curve = xml['curve']
    end
  end
