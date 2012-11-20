#
# Drawing definitions
#
class Eagle < LibEagle::Base
  is_root
  object :compatibility
  object :drawing
  attribute :version, :required => true
end

class Compatibility < LibEagle::Base
  object :note
end

class Note < LibEagle::Base
  has_content
  attribute :version, :required => true
  attribute :severity, :required => true
end

class Drawing < LibEagle::Base
  object :settings
  object :grid
  object :layers
  object :library
  object :schematic
  object :board
end

class Library < LibEagle::Base
  object :description
  object :packages
  object :symbols
  object :devicesets
  attribute :name
end

class Schematic < LibEagle::Base
  object :description
  object :libraries
  object :attributes
  object :variantdefs
  object :classes
  object :parts
  object :sheets
  object :errors
  attribute :xreflabel
  attribute :xrefpart
end

class Board < LibEagle::Base
  object :description
  object :plain
  object :libraries
  object :attributes
  object :variantdefs
  object :classes
  object :designrules
  object :autorouter
  object :elements
  object :signals
  object :errors
end

#
# High Level Objects
#
class Sheet < LibEagle::Base
  object :description
  object :plain
  object :instances
  object :busses
  object :nets
end

class Package < LibEagle::Base
  object :description
  object :polygon
  object :wire
  object :text
  object :circle
  object :rectangle
  object :frame
  object :hole
  object :pad
  object :smd
  attribute :name, :required => true
end

class SSymbol < LibEagle::Base
  has_class_name "symbol"
  object :description
  object :polygon
  object :wire
  object :text
  object :pin
  object :circle
  object :rectangle
  object :frame
  attribute :name, :required => true
end

class Deviceset < LibEagle::Base
  object :description
  object :gates
  object :devices
  attribute :name, :required => true
  attribute :prefix, :default => ""
  attribute :uservalue, :default => "no"
end

class Device < LibEagle::Base
  object :connects
  object :technologies
  attribute :name, :default => ""
  attribute :package
end

class Bus < LibEagle::Base
  object :segment
  attribute :name, :required => true
end

class Net < LibEagle::Base
  object :segment
  attribute :name, :required => true
  attribute :class, :default => "0"
end

class Segment < LibEagle::Base
  object :pinref
  object :wire
  object :junction
  object :label
end

class SSignal < LibEagle::Base
  attribute :name, :required => true
  attribute :class, :default => "0"
  attribute :airwireshidden, :default => "no"
  object :contactref
  object :polygon
  object :wire
  object :via
end

#
# Basic Objects
#
class Variantdef < LibEagle::Base
  no_end_tag
  attribute :name, :required => true
  attribute :current, :default => "no"
end

class Variant < LibEagle::Base
  no_end_tag
  attribute :name, :required => true
  attribute :populate, :default => "yes"
  attribute :value
  attribute :technology
end

class Gate < LibEagle::Base
  no_end_tag
  attribute :name, :required => true
  attribute :symbol, :required => true
  attribute :x, :required => true
  attribute :y, :required => true
  attribute :addlevel, :default => "next"
  attribute :swaplevel, :default => 0
end

class Wire < LibEagle::Base
  no_end_tag
  attribute :x1, :required => true
  attribute :y1, :required => true
  attribute :x2, :required => true
  attribute :y2, :required => true
  attribute :width, :required => true
  attribute :layer, :required => true
  attribute :extent
  attribute :style, :default => "continuous"
  attribute :curve, :default => "0"
  attribute :cap, :default => "round"
end

class Dimension < LibEagle::Base
  no_end_tag
  attribute :x1, :required => true
  attribute :y2, :required => true
  attribute :x2, :required => true
  attribute :y2, :required => true
  attribute :x3, :required => true
  attribute :y3, :required => true
  attribute :layer, :required => true
  attribute :dtype, :default => "continuous"
end

class Text < LibEagle::Base
  has_content
  attribute :x, :required => true
  attribute :y, :required => true
  attribute :size, :required => true
  attribute :layer, :required => true
  attribute :font, :default => "proportional"
  attribute :ratio, :default => "8"
  attribute :rot, :default => "R0"
  attribute :align, :default => "bottom-left"
  attribute :distance, :default => "50"
end

class Circle < LibEagle::Base
  no_end_tag
  attribute :x, :required => true
  attribute :y, :required => true
  attribute :radius, :required => true
  attribute :width, :required => true
  attribute :layer, :required => true
end

class Rectangle < LibEagle::Base
  no_end_tag
  attribute :x1, :required => true
  attribute :y1, :required => true
  attribute :x2, :required => true
  attribute :y2, :required => true
  attribute :layer, :required => true
  attribute :rot, :default => "R0"
end

class Frame < LibEagle::Base
  no_end_tag
  attribute :x1, :required => true
  attribute :y2, :required => true
  attribute :x2, :required => true
  attribute :y2, :required => true
  attribute :columns, :required => true
  attribute :rows, :required => true
  attribute :layer, :required => true
  attribute :border_left, :default => "yes"
  attribute :border_top, :default => "yes"
  attribute :border_right, :default => "yes"
  attribute :border_bottom, :default => "yes"
end

class Hole < LibEagle::Base
  no_end_tag
  attribute :x, :required => true
  attribute :y, :required => true
  attribute :drill, :required => true
end       


class Pad < LibEagle::Base
  no_end_tag
  attribute :name, :required => true
  attribute :x, :required => true
  attribute :y, :required => true
  attribute :drill, :required => true
  attribute :diameter, :default => "0"
  attribute :shape, :default => "round"
  attribute :rot, :default => "R0"
  attribute :stop, :default => "yes"
  attribute :thermals, :default => "yes"
  attribute :first, :default => "no"
end

class Smd < LibEagle::Base
  no_end_tag
  attribute :name, :required => true
  attribute :x, :required => true
  attribute :y, :required => true
  attribute :dx, :required => true
  attribute :dy, :required => true
  attribute :layer, :required => true
  attribute :roundness, :default => "0"
  attribute :rot, :default => "R0"
  attribute :stop, :default => "yes"
  attribute :thermals, :default => "yes"
  attribute :cream, :default => "yes"
end

class Element < LibEagle::Base
  object :attribute
  object :variant
  attribute :name, :required => true
  attribute :library, :required => true
  attribute :package, :required => true
  attribute :value, :required => true
  attribute :x, :required => true
  attribute :y, :required => true
  attribute :locked, :default => "no"
  attribute :smashed, :default => "no"
  attribute :rot, :default => "R0"
end

class Via < LibEagle::Base
  no_end_tag
  attribute :x, :required => true
  attribute :y, :required => true
  attribute :extent, :required => true
  attribute :drill, :required => true
  attribute :diameter, :default => "0"
  attribute :shape, :default => "round"
  attribute :alwaysstop, :default => "no"
end

class Polygon < LibEagle::Base
  object :vertex
  attribute :width, :required => true
  attribute :layer, :required => true
  attribute :spacing
  attribute :pour, :default => "solid"
  attribute :isolate
  attribute :orphans, :default => "no"
  attribute :thermals, :default => "yes"
  attribute :rank, :default => "0"
end

class Vertex < LibEagle::Base
  no_end_tag
  attribute :x, :required => true
  attribute :y, :required => true
  attribute :curve, :default => "0"
end

class Pin < LibEagle::Base
  no_end_tag
  attribute :name, :required => true
  attribute :x, :required => true
  attribute :y, :required => true
  attribute :visible, :default => "both"
  attribute :length, :default => "long"
  attribute :direction, :default => "io"
  attribute :function, :default => "none"
  attribute :swaplevel, :default => "0"
  attribute :rot, :default => "R0"
end

class Part < LibEagle::Base
  object :attribute
  object :variant
  attribute :name, :required => true
  attribute :library, :required => true
  attribute :deviceset, :required => true
  attribute :device, :required => true
  attribute :technology, :default => ""
  attribute :value
end

class Instance < LibEagle::Base
  object :attribute
  attribute :part, :required => true
  attribute :gate, :required => true
  attribute :x, :required => true
  attribute :y, :required => true
  attribute :smashed, :default => "no"
  attribute :rot, :default => "R0"
end

class Label < LibEagle::Base
  no_end_tag
  attribute :x, :required => true
  attribute :y, :required => true
  attribute :size, :required => true
  attribute :layer, :required => true
  attribute :font, :default => "proportional"
  attribute :ratio, :default => "8"
  attribute :rot, :default => "R0"
  attribute :xref, :default => "no"
end

class Junction < LibEagle::Base
  no_end_tag
  attribute :x, :required => true
  attribute :y, :required => true
end

class Connect < LibEagle::Base
  no_end_tag
  attribute :gate, :required => true
  attribute :pin, :required => true
  attribute :pad, :required => true
  attribute :route, :default => "all"
end

class Technology < LibEagle::Base
  object :attribute
  attribute :name, :required => true
end

class Attribute < LibEagle::Base
  no_end_tag
  attribute :name, :required => true
  attribute :value
  attribute :x
  attribute :y
  attribute :size
  attribute :layer
  attribute :font
  attribute :ratio
  attribute :rot, :default => "R0"
  attribute :display, :default => "value"
  attribute :constant, :default => "no"
end

class Pinref < LibEagle::Base
  no_end_tag
  attribute :part, :required => true
  attribute :gate, :required => true
  attribute :pin, :required => true
end

class Contactref < LibEagle::Base
  no_end_tag
  attribute :element, :required => true
  attribute :pad, :required => true
  attribute :route, :default => "all"
  attribute :routetag, :default => ""
end

#
# Object Lists
#
class Variantdefs < LibEagle::Base
  object :variantdef
end

class Settings < LibEagle::Base
  object :setting
end

class Sheets < LibEagle::Base
  object :sheet
end

class Layers < LibEagle::Base
  object :layer
end

class Packages < LibEagle::Base
  object :package
end

class Symbols < LibEagle::Base
  object :symbol, :class => "SSymbol"
end

class Devicesets < LibEagle::Base
  object :deviceset
end

class Gates < LibEagle::Base
  object :gate
end

class Devices < LibEagle::Base
  object :device
end

class Libraries < LibEagle::Base
  object :librarie
end

class Connects < LibEagle::Base
  object :connect
end

class Technologies < LibEagle::Base
  object :technologie
end

class Attributes < LibEagle::Base
  object :attribute
end

class Classes < LibEagle::Base
  object :class, :class => "CClass"
end

class Parts < LibEagle::Base
  object :part
end

class Instances < LibEagle::Base
  object :instance
end

class Errors < LibEagle::Base
  object :error
end

class Plain < LibEagle::Base
  object :polygon
  object :wire
  object :text
  object :circle
  object :rectangle
  object :frame
  object :hole
end

class Autorouter < LibEagle::Base
  object :passe
end

class Elements < LibEagle::Base
  object :element
end

class Signals < LibEagle::Base
  object :signal
end

class Busses < LibEagle::Base
  object :busse
end

class Nets < LibEagle::Base
  object :net
end

#
# Miscellaneous Objects
#
class Setting < LibEagle::Base
  no_end_tag
  attribute :alwaysvectorfont
  attribute :verticaltext
end

class Designrules < LibEagle::Base
  object :description
  object :param
  attribute :name, :required => true
end

class Grid < LibEagle::Base
  no_end_tag
  attribute :distance
  attribute :unitdist
  attribute :unit
  attribute :style, :default => "lines"
  attribute :multiple, :default => "0"
  attribute :display, :default => "no"
  attribute :altdistance
  attribute :altunitdist
  attribute :altunit
end

class Layer < LibEagle::Base
  no_end_tag
  attribute :number, :required => true
  attribute :name, :required => true
  attribute :color, :required => true
  attribute :fill, :required => true
  attribute :visible, :default => "yes"
  attribute :active, :default => "yes"
end

class CClass < LibEagle::Base
  object :clearance
  attribute :number, :required => true
  attribute :name, :required => true
  attribute :width, :default => "0"
  attribute :drill, :default => "0"
end

class Clearance < LibEagle::Base
  no_end_tag
  attribute :class, :required => true
  attribute :value, :default => "0"
end

class Description < LibEagle::Base
  has_content
  attribute :language
end

class Param < LibEagle::Base
  no_end_tag
  attribute :name, :required => true
  attribute :value, :required => true
end

class Pass < LibEagle::Base
  object :param
  attribute :name, :required => true
  attribute :refer
  attribute :active, :default => "yes"
end

class Approved < LibEagle::Base
  no_end_tag
  attribute :hash, :required => true
end