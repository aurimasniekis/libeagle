#
# Drawing definitions
#
class Eagle
  attr_accessor :compatibility,
                :drawing,
                :version
end

class Compatibility
  attr_accessor :note
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
end

class Library
  attr_accessor :description,
                :packages,
                :symbols,
                :devicesets,
                :name
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

#
# High Level Objects
#
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
                :cclass
end

class Segment
  attr_accessor :pinref,
                :wire,
                :junction,
                :label
end

class SSignal
  attr_accessor :name,
                :cclass,
                :airwireshidden,
                :contactref,
                :polygon,
                :wire,
                :via
end

#
# Basic Objects
#
class Variantdef
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
end

class Circle
  attr_accessor :x,
                :y,
                :radius,
                :width,
                :layer
end

class Rectangle
  attr_accessor :x1,
                :y1,
                :x2,
                :y2,
                :layer,
                :rot
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
end

class Hole
  attr_accessor :x,
                :y,
                :drill
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
end

class Via
  attr_accessor :x,
                :y,
                :extent,
                :drill,
                :diameter,
                :shape,
                :alwaysstop
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
end

class Vertex
  attr_accessor :x,
                :y,
                :curve
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
end

class Instance
  attr_accessor :attribute,
                :part,
                :gate,
                :x,
                :y,
                :smashed,
                :rot
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
end

class Junction
  attr_accessor :x,
                :y
end

class Connect
  attr_accessor :gate,
                :pin,
                :pad,
                :route
end

class Technology
  attr_accessor :attribute,
                :name
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
end

class Pinref
  attr_accessor :part,
                :gate,
                :pin
end

class Contactref
  attr_accessor :element,
                :pad,
                :route,
                :routetag
end

#
# Object Lists
#
class Variantdefs
  attr_accessor :variantdefs
end

class Settings
  attr_accessor :settings
end

class Sheets
  attr_accessor :sheets
end

class Layers
  attr_accessor :layers
end

class Packages
  attr_accessor :packages
end

class Symbols
  attr_accessor :symbols
end

class Devicesets
  attr_accessor :devicesets
end

class Gates
  attr_accessor :gates
end

class Devices
  attr_accessor :devices
end

class Libraries
  attr_accessor :libraries
end

class Connects
  attr_accessor :connects
end

class Technologies
  attr_accessor :technologies
end

class Attributes
  attr_accessor :attributes
end

class Classes
  attr_accessor :classes
end

class Parts
  attr_accessor :parts
end

class Instances
  attr_accessor :instances
end

class Errors
  attr_accessor :errors
end

class Plain
  attr_accessor :polygon,
                :wire,
                :text,
                :circle,
                :rectangle,
                :frame,
                :hole
end

class Autorouter
  attr_accessor :passes
end

class Elements
  attr_accessor :elements
end

class Signals
  attr_accessor :signals
end

class Busses
  attr_accessor :busses
end

class Nets
  attr_accessor :nets

  def initialize(xml)
end

#
# Miscellaneous Objects
#
class Setting
  attr_accessor :alwaysvectorfont,
                :verticaltext
end

class Designrules
  attr_accessor :description,
                :param,
                :name
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
end

class Layer
  attr_accessor :number,
                :name,
                :color,
                :fill,
                :visible,
                :active
end

class CClass
  attr_accessor :clearance,
                :number,
                :name,
                :width,
                :drill
end

class Clearance
  attr_accessor :cclass,
                :value
end

class Description
  attr_accessor :language,
                :description
end

class Param
  attr_accessor :name,
                :value
end

class Pass
  attr_accessor :param,
                :name,
                :refer,
                :active
end

class Approved
  attr_accessor :hash
end