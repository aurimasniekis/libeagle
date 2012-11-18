#
# Drawing definitions
#
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
      @layers = Layers.new(layers)
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
      @description = Description.new(description)
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
      devicesets = xml.xpath('devicesets/deviceset')
      @devicesets = Devicesets.new(devicesets)
    end
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

  def initialize(xml)
    if description = xml.xpath('description').first
      @description = Description.new(description)
    end

    if xml.xpath('libraries/library').size > 0
      libraries = xml.xpath('libraries/library')
      @libraries = Libraries.new(libraries)
    end
    if xml.xpath('attributes/attribute').size > 0
      attributes = xml.xpath('attributes/attribute')
      @attributes = Attributes.new(attributes)
    end
    if xml.xpath('variantdefs/variantdef').size > 0
      variantdefs = xml.xpath('variantdefs/variantdef')
      @variantdefs = Variantdefs.new(variantdefs)
    end
    if xml.xpath('classes/class').size > 0
      classes = xml.xpath('classes/class')
      @classes = Classes.new(classes)
    end
    if xml.xpath('parts/part').size > 0
      parts = xml.xpath('parts/part')
      @parts = Parts.new(parts)
    end
    if xml.xpath('sheets/sheet').size > 0
      sheets = xml.xpath('sheets/sheet')
      @sheets = Sheets.new(sheets)
    end
    if xml.xpath('errors/error').size > 0
      errors = xml.xpath('errors/error')
      @errors = Errors.new(errors)
    end
    @xreflabel = xml['xreflabel']
    @xrefpart = xml['xrefpart']
  end
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

#
# High Level Objects
#
class Sheet
  attr_accessor :description,
                :plain,
                :instances,
                :busses,
                :nets

  def initialize(xml)
    if description = xml.xpath('description').first
      @description = Description.new(description)
    end
    if xml.xpath('plain').size > 0  
      @plain = []
      xml.xpath('plain').each do |plain|
        @plain << Plain.new(plain)
      end
    end

    if xml.xpath('instances/instance').size > 0
      instances = xml.xpath('instances/instance')
      @instances = Instances.new(instances)
    end

    if xml.xpath('busses/bus').size > 0
      busses = xml.xpath('busses/bus')
      @busses = Busses.new(busses)
    end

    if xml.xpath('nets/net').size > 0
      nets = xml.xpath('nets/net')
      @nets = Nets.new(nets)
    end

  end
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

  def initialize(xml)
    @name = xml['name']
    @prefix = xml['prefix']
    @uservalue = xml['uservalue']

    if description = xml.xpath('description').first
      @description = Description.new(description)
    end

    if xml.xpath('gates/gate').size > 0
      gates = xml.xpath('gates/gate')
      @gates = Gates.new(gates)
    end 

    if xml.xpath('devices/device').size > 0
      devices = xml.xpath('devices/device')
      @devices = Devices.new(devices)
    end

  end
end

class Device
  attr_accessor :connects,
                :technologies,
                :name,
                :package

  def initialize(xml)
    if xml.xpath('connects/connect').size > 0
      connects = xml.xpath('connects/connect')
      @connects = Connects.new(connects)
    end

    if xml.xpath('technologies/technology').size > 0
      technologies = xml.xpath('technologies/technology')
      @technologies = Technologies.new(technologies)
    end

    @name = xml['name']
    @package = xml['package']
  end
end

class Bus
  attr_accessor :segment,
                :name

  def initialize(xml)
    if xml.xpath('segment').size > 0
      @segment = []
      xml.xpath('segment').each do |segment|
        @segment << Segment.new(segment)
      end
    end
    @name = xml['name']
  end
end

class Net
  attr_accessor :segment,
                :name,
                :cclass

  def initialize(xml)
    if xml.xpath('segment').size > 0
      @segment = []
      xml.xpath('segment').each do |segment|
        @segment << Segment.new(segment)
      end
    end
    @name = xml['name']
    @cclass = xml['cclass']  
  end
end

class Segment
  attr_accessor :pinref,
                :wire,
                :junction,
                :label

  def initialize(xml)
    if xml.xpath('pinref').size > 0
      @pinref = []
      xml.xpath('pinref').each do |pinref|
        @pinref << Pinref.new(pinref)
      end
    end
    if xml.xpath('wire').size > 0
      @wire = []
      xml.xpath('wire').each do |wire|
        @wire << Wire.new(wire)
      end
    end
    if xml.xpath('junction').size > 0
      @junction = []
      xml.xpath('junction').each do |junction|
        @junction << Junction.new(junction)
      end
    end
    if xml.xpath('label').size > 0
      @label = []
      xml.xpath('label').each do |label|
        @label << Label.new(label)
      end
    end
  end
end

class SSignal
  attr_accessor :name,
                :cclass,
                :airwireshidden,
                :contactref,
                :polygon,
                :wire,
                :via
  def initialize(xml)
    @name = xml['name']
    @cclass = xml['cclass']
    @airwireshidden = xml['airwireshidden']
    if xml.xpath('contactref').size > 0
      @contactref = []
      xml.xpath('contactref').each do |contactref|
        @contactref << Contactref.new(contactref)
      end
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
    if xml.xpath('via').size > 0
      @via = []
      xml.xpath('via').each do |via|
        @via << Via.new(via)
      end
    end
  end
end

#
# Basic Objects
#
class Variantdef
  attr_accessor :name,
                :current

  def initialize(xml)
    @name = xml['name']
    @current = xml['current']
  end
end

class Variant
  attr_accessor :name,
                :populate,
                :value,
                :technology

  def initialize(xml)
    @name = xml['name']
    @populate = xml['populate']
    @value = xml['value']
    @technology = xml['technology']
  end
end

class Gate
  attr_accessor :name,
                :symbol,
                :x,
                :y,
                :addlevel,
                :swaplevel
  
  def initialize(xml)
    @name = xml['name']
    @symbol = xml['symbol']
    @x = xml['x']
    @y = xml['y']
    @addlevel = xml['addlevel']
    @swaplevel = xml['swaplevel']
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

class Dimension
  attr_accessor :x1,
                :y2,
                :x2,
                :y2,
                :x3,
                :y3,
                :layer,
                :dtype
  def initialize(xml)
    @x1 = xml['x1']
    @y2 = xml['y2']
    @x2 = xml['x2']
    @y2 = xml['y2']
    @x3 = xml['x3']
    @y3 = xml['y3']
    @layer = xml['layer']
    @dtype = xml['dtype']
  end
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

class Element
  attr_accessor :attribute,
                :variant,
                :name,
                :library,
                :package,
                :value,
                :x,
                :y,
                :locked,
                :smashed,
                :rot

  def initialize(xml)
    if xml.xpath('attribute').size > 0
      @attribute = []
      xml.xpath('attribute').each do |attribute|
        @attribute << Attribute.new(attribute)
      end
    end
    if xml.xpath('variant').size > 0
      @variant = []
      xml.xpath('variant').each do |variant|
        @variant << Variant.new(variant)
      end
    end
    @name = xml['name']
    @library = xml['library']
    @package = xml['package']
    @value = xml['value']
    @x = xml['x']
    @y = xml['y']
    @locked = xml['locked']
    @smashed = xml['smashed']
    @rot = xml['rot']
  end
end

class Via
  attr_accessor :x,
                :y,
                :extent,
                :drill,
                :diameter,
                :shape,
                :alwaysstop

  def initialize(xml)
    @x = xml['x']
    @y = xml['y']
    @extent = xml['extent']
    @drill = xml['drill']
    @diameter = xml['diameter']
    @shape = xml['shape']
    @alwaysstop = xml['alwaysstop']
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

class Part
  attr_accessor :attribute,
                :variant,
                :name,
                :library,
                :deviceset,
                :device,
                :technology,
                :value

  def initialize(xml)
    if xml.xpath('attribute').size > 0
      @attribute = []
      xml.xpath('attribute').each do |attribute|
        @attribute << Attribute.new(attribute)
      end
    end
    if xml.xpath('variant').size > 0
      @variant = []
      xml.xpath('variant').each do |variant|
        @variant << Variant.new(variant)
      end
    end
    @name = xml['name']
    @library = xml['library']
    @deviceset = xml['deviceset']
    @device = xml['device']
    @technology = xml['technology']
    @value = xml['value']
  end
end

class Instance
  attr_accessor :attribute,
                :part,
                :gate,
                :x,
                :y,
                :smashed,
                :rot

  def initialize(xml)
    if xml.xpath('attribute').size > 0
      @attribute = []
      xml.xpath('attribute').each do |attribute|
        @attribute << Attribute.new(attribute)
      end
    end
    @part = xml['part']
    @gate = xml['gate']
    @x = xml['x']
    @y = xml['y']
    @smashed = xml['smashed']
    @rot = xml['rot']
  end
end

class Label
  attr_accessor :x,
                :y,
                :size,
                :layer,
                :font,
                :ratio,
                :rot,
                :xref

  def initialize(xml)
    @x = xml['x']
    @y = xml['y']
    @size = xml['size']
    @layer = xml['layer']
    @font = xml['font']
    @ratio = xml['ratio']
    @rot = xml['rot']
    @xref = xml['xref']
  end
end

class Junction
  attr_accessor :x,
                :y

  def initialize(xml)
    @x = xml['x']
    @y = xml['y']
  end
end

class Connect
  attr_accessor :gate,
                :pin,
                :pad,
                :route

  def initialize(xml)
    @gate = xml['gate']
    @pin = xml['pin']
    @pad = xml['pad']
    @route = xml['route']
  end
end

class Technology
  attr_accessor :attribute,
                :name

  def initialize(xml)
    @name = xml['name']
    if xml.xpath('attribute').size > 0
      @attribute = []
      xml.xpath('attribute').each do |attribute|
        @attribute << Attribute.new(attribute)
      end
    end
  end
end

class Attribute
  attr_accessor :name,
                :value,
                :x,
                :y,
                :size,
                :layer,
                :font,
                :ratio,
                :rot,
                :display,
                :constant

  def initialize(xml)
    @name = xml['name']
    @value = xml['value']
    @x = xml['x']
    @y = xml['y']
    @size = xml['size']
    @layer = xml['layer']
    @font = xml['font']
    @ratio = xml['ratio']
    @rot = xml['rot']
    @display = xml['display']
    @constant = xml['constant']
  end
end

class Pinref
  attr_accessor :part,
                :gate,
                :pin

  def initialize(xml)
    @part = xml['part']
    @gate = xml['gate']
    @pin = xml['pin']
  end
end

class Contactref
  attr_accessor :element,
                :pad,
                :route,
                :routetag

  def initialize(xml)
    @element = xml['element']
    @pad = xml['pad']
    @route = xml['route']
    @routetag = xml['routetag']
  end
end

#
# Object Lists
#
class Variantdefs
  attr_accessor :variantdefs

  def initialize(xml)
    @variantdefs = []
    xml.each do |v|
      @variantdefs << Variantdef.new(v)
    end
  end
end

class Settings
  attr_accessor :settings

  def initialize(xml)
    @settings = []
    xml.each do |s|
      @settings << Setting.new(s)
    end
  end
end

class Sheets
  attr_accessor :sheets

  def initialize(xml)
    @sheets = []
    xml.each do |s|
      @sheets << Sheet.new(s)
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

class Gates
  attr_accessor :gates

  def initialize(xml)
    @gates = []
    xml.each do |g|
      @gates << Gate.new(g)
    end
  end 
end

class Devices
  attr_accessor :devices

  def initialize(xml)
    @devices = []
    xml.each do |d|
      @devices << Device.new(d)
    end
  end
end

class Libraries
  attr_accessor :libraries

  def initialize(xml)
    @libraries = []
    xml.each do |l|
      @libraries << Library.new(l)
    end
  end
end

class Connects
  attr_accessor :connects

  def initialize(xml)
    @connects = []
    xml.each do |c|
      @connects << Connect.new(c)
    end
  end
end

class Technologies
  attr_accessor :technologies

  def initialize(xml)
    @technologies = []
    xml.each do |t|
      @technologies << Technology.new(t)
    end
  end
end

class Attributes
  attr_accessor :attributes

  def initialize(xml)
    @attributes = []
    xml.each do |a|
      @attributes << Attribute.new(a)
    end
  end
end

class Classes
  attr_accessor :classes

  def initialize(xml)
    @classes = []
    xml.each do |c|
      @classes << CClass.new(c)
    end
  end
end

class Parts
  attr_accessor :parts

  def initialize(xml)
    @parts = []
    xml.each do |p|
      @parts << Part.new(p)
    end
  end
end

class Instances
  attr_accessor :instances

  def initialize(xml)
    @instances = []
    xml.each do |i|
      @instances << Instance.new(i)
    end
  end
end

class Errors
  attr_accessor :errors

  def initialize(xml)
    @errors = []
    xml.each do |e|
      @errors << Error.new(e)
    end
  end
end

class Plain
  attr_accessor :polygon,
                :wire,
                :text,
                :circle,
                :rectangle,
                :frame,
                :hole

  def initialize(xml)
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
  end
end

class Autorouter
  attr_accessor :passes

  def initialize(xml)
    @passes = []
    xml.each do |p|
      @passes << Pass.new(p)
    end
  end
end

class Elements
  attr_accessor :elements

  def initialize(xml)
    @elements = []
    xml.each do |e|
      @elements << Element.new(e)
    end
  end
end

class Signals
  attr_accessor :signals

  def initialize(xml)
    @signals = []
    xml.each do |s|
      @signals << Signal.new(s)
    end
  end
end

class Busses
  attr_accessor :busses

  def initialize(xml)
    @busses = []
    xml.each do |b|
      @busses << Bus.new(b)
    end
  end
end

class Nets
  attr_accessor :nets

  def initialize(xml)
    @nets = []
    xml.each do |n|
      @nets << Net.new(n)
    end
  end
end

#
# Miscellaneous Objects
#
class Setting
  attr_accessor :alwaysvectorfont,
                :verticaltext

  def initialize(xml)
    @alwaysvectorfont = xml['alwaysvectorfont'] if xml['alwaysvectorfont']
    @verticaltext = xml['verticaltext'] if xml['verticaltext']
  end
end

class Designrules
  attr_accessor :description,
                :param,
                :name

  def initialize(xml)
    if description = xml.xpath('description').first
      @description = Description.new(description)
    end
    if xml.xpath('param').size > 0
      @param = []
      xml.xpath('param').each do |param|
        @param << Param.new(param)
      end
    end
    @name = xml['name']
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

class CClass
  attr_accessor :clearance,
                :number,
                :name,
                :width,
                :drill

  def initialize(xml)
    if xml.xpath('clearance').size > 0
      @clearance = []
      xml.xpath('clearance').each do |clearance|
        @clearance << Clearance.new(clearance)
      end
    end
    @number = xml['number']
    @name = xml['name']
    @width = xml['width']
    @drill = xml['drill']
  end
end

class Clearance
  attr_accessor :cclass,
                :value

  def initialize(xml)
    @cclass = xml['cclass']
    @value = xml['value']
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

class Param
  attr_accessor :name,
                :value

  def initialize(xml)
    @name = xml['name']
    @value = xml['value']
  end           
end

class Pass
  attr_accessor :param,
                :name,
                :refer,
                :active

  def initialize(xml)
    if xml.xpath('param').size > 0
      @param = []
      xml.xpath('param').each do |param|
        @param << Param.new(param)
      end
    end
    @name = xml['name']
    @refer = xml['refer']
    @active = xml['active']
  end
end

class Approved
  attr_accessor :hash

  def initialize(xml)
    @hash = xml['hash']
  end
end