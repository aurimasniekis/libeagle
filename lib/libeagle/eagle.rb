require_relative "types"
module LibEagle

  CLASS_NAMES = {
    'eagle' => "Eagle",
    'compatibility' => "Compatibility",
    'note' => "Note",
    'drawing' => "Drawing",
    'library' => "Library",
    'schematic' => "Schematic",
    'board' => "Board",
    'sheet' => "Sheet",
    'package' => "Package",
    'symbol' => "Symbol",
    'deviceset' => "Deviceset",
    'device' => "Device",
    'bus' => "Bus",
    'net' => "Net",
    'segment' => "Segment",
    'signal' => "Signal",
    'variantdef' => "Variantdef",
    'variant' => "Variant",
    'gate' => "Gate",
    'wire' => "Wire",
    'dimension' => "Dimension",
    'text' => "Text",
    'circle' => "Circle",
    'rectangle' => "Rectangle",
    'frame' => "Frame",
    'hole' => "Hole",
    'pad' => "Pad",
    'smd' => "Smd",
    'element' => "Element",
    'via' => "Via",
    'polygon' => "Polygon",
    'vertex' => "Vertex",
    'pin' => "Pin",
    'part' => "Part",
    'instance' => "Instance",
    'label' => "Label",
    'junction' => "Junction",
    'connect' => "Connect",
    'technology' => "Technology",
    'attribute' => "Attribute",
    'pinref' => "Pinref",
    'contactref' => "Contactref",
    'variantdefs' => "Variantdefs",
    'settings' => "Settings",
    'sheets' => "Sheets",
    'layers' => "Layers",
    'packages' => "Packages",
    'symbols' => "Symbols",
    'devicesets' => "Devicesets",
    'gates' => "Gates",
    'devices' => "Devices",
    'libraries' => "Libraries",
    'connects' => "Connects",
    'technologies' => "Technologies",
    'attributes' => "Attributes",
    'classes' => "Classes",
    'parts' => "Parts",
    'instances' => "Instances",
    'errors' => "Errors",
    'plain' => "Plain",
    'autorouter' => "Autorouter",
    'elements' => "Elements",
    'signals' => "Signals",
    'busses' => "Busses",
    'nets' => "Nets",
    'setting' => "Setting",
    'designrules' => "Designrules",
    'grid' => "Grid",
    'layer' => "Layer",
    'cclass' => "CClass",
    'clearance' => "Clearance",
    'description' => "Description",
    'param' => "Param",
    'pass' => "Pass",
    'approved' => "Approved"}

  #
  # Drawing definitions
  #
  class Eagle < LibEagle::Base
    root_element
    object :compatibility
    object :drawing
    attribute :version, :required => true
  end

  class Compatibility < LibEagle::Base
    object :note
  end

  class Note < LibEagle::Base
    text_content
    attribute :version, :required => true
    attribute :severity, :required => true, :type => LibEagle::Types.Severity
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
    object :wire
    object :circle
    object :frame
    object :hole
    object :pad
    object :smd
    object :text
    object :rectangle
    object :polygon
    attribute :name, :required => true
  end

  class Symbol < LibEagle::Base
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
    attribute :uservalue, :default => "no", :type => LibEagle::Types.Bool
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

  class Signal < LibEagle::Base
    attribute :name, :required => true
    attribute :class, :default => "0"
    attribute :airwireshidden, :default => "no", :type => LibEagle::Types.Bool
    object :contactref
    object :polygon
    object :wire
    object :via
  end

  #
  # Basic Objects
  #
  class Variantdef < LibEagle::Base
    empty_element
    attribute :name, :required => true
    attribute :current, :default => "no", :type => LibEagle::Types.Bool
  end

  class Variant < LibEagle::Base
    empty_element
    attribute :name, :required => true
    attribute :populate, :default => "yes", :type => LibEagle::Types.Bool
    attribute :value
    attribute :technology
  end

  class Gate < LibEagle::Base
    empty_element
    attribute :name, :required => true
    attribute :symbol, :required => true
    attribute :x, :required => true
    attribute :y, :required => true
    attribute :addlevel, :default => "next", :type => LibEagle::Types.GateAddLevel
    attribute :swaplevel, :default => 0
  end

  class Wire < LibEagle::Base
    empty_element
    attribute :x1, :required => true
    attribute :y1, :required => true
    attribute :x2, :required => true
    attribute :y2, :required => true
    attribute :width, :required => true
    attribute :layer, :required => true
    attribute :extent
    attribute :style, :default => "continuous", :type => LibEagle::Types.WireStyle
    attribute :curve, :default => "0"
    attribute :cap, :default => "round", :type => LibEagle::Types.WireCap
  end

  class Dimension < LibEagle::Base
    empty_element
    attribute :x1, :required => true
    attribute :y2, :required => true
    attribute :x2, :required => true
    attribute :y2, :required => true
    attribute :x3, :required => true
    attribute :y3, :required => true
    attribute :layer, :required => true
    attribute :dtype, :default => "continuous", :type => LibEagle::Types.DimensionType
  end

  class Text < LibEagle::Base
    text_content
    attribute :x, :required => true
    attribute :y, :required => true
    attribute :size, :required => true
    attribute :layer, :required => true
    attribute :font, :default => "proportional", :type => LibEagle::Types.TextFont
    attribute :ratio, :default => "8"
    attribute :rot, :default => "R0"
    attribute :align, :default => "bottom-left", :type => LibEagle::Types.Align
    attribute :distance, :default => "50"
  end

  class Circle < LibEagle::Base
    empty_element
    attribute :x, :required => true
    attribute :y, :required => true
    attribute :radius, :required => true
    attribute :width, :required => true
    attribute :layer, :required => true
  end

  class Rectangle < LibEagle::Base
    empty_element
    attribute :x1, :required => true
    attribute :y1, :required => true
    attribute :x2, :required => true
    attribute :y2, :required => true
    attribute :layer, :required => true
    attribute :rot, :default => "R0"
  end

  class Frame < LibEagle::Base
    empty_element
    attribute :x1, :required => true
    attribute :y2, :required => true
    attribute :x2, :required => true
    attribute :y2, :required => true
    attribute :columns, :required => true
    attribute :rows, :required => true
    attribute :layer, :required => true
    attribute :border_left, :default => "yes", :type => LibEagle::Types.Bool
    attribute :border_top, :default => "yes", :type => LibEagle::Types.Bool
    attribute :border_right, :default => "yes", :type => LibEagle::Types.Bool
    attribute :border_bottom, :default => "yes", :type => LibEagle::Types.Bool
  end

  class Hole < LibEagle::Base
    empty_element
    attribute :x, :required => true
    attribute :y, :required => true
    attribute :drill, :required => true
  end       


  class Pad < LibEagle::Base
    empty_element
    attribute :name, :required => true
    attribute :x, :required => true
    attribute :y, :required => true
    attribute :drill, :required => true
    attribute :diameter, :default => "0"
    attribute :shape, :default => "round", :type => LibEagle::Types.PadShape
    attribute :rot, :default => "R0"
    attribute :stop, :default => "yes", :type => LibEagle::Types.Bool
    attribute :thermals, :default => "yes", :type => LibEagle::Types.Bool
    attribute :first, :default => "no", :type => LibEagle::Types.Bool
  end

  class Smd < LibEagle::Base
    empty_element
    attribute :name, :required => true
    attribute :x, :required => true
    attribute :y, :required => true
    attribute :dx, :required => true
    attribute :dy, :required => true
    attribute :layer, :required => true
    attribute :roundness, :default => "0"
    attribute :rot, :default => "R0"
    attribute :stop, :default => "yes", :type => LibEagle::Types.Bool
    attribute :thermals, :default => "yes", :type => LibEagle::Types.Bool
    attribute :cream, :default => "yes", :type => LibEagle::Types.Bool
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
    attribute :locked, :default => "no", :type => LibEagle::Types.Bool
    attribute :smashed, :default => "no", :type => LibEagle::Types.Bool
    attribute :rot, :default => "R0"
  end

  class Via < LibEagle::Base
    empty_element
    attribute :x, :required => true
    attribute :y, :required => true
    attribute :extent, :required => true
    attribute :drill, :required => true
    attribute :diameter, :default => "0"
    attribute :shape, :default => "round", :type => LibEagle::Types.ViaShape
    attribute :alwaysstop, :default => "no", :type => LibEagle::Types.Bool
  end

  class Polygon < LibEagle::Base
    object :vertex
    attribute :width, :required => true
    attribute :layer, :required => true
    attribute :spacing
    attribute :pour, :default => "solid", :type => LibEagle::Types.PolygonPour
    attribute :isolate
    attribute :orphans, :default => "no", :type => LibEagle::Types.Bool
    attribute :thermals, :default => "yes", :type => LibEagle::Types.Bool
    attribute :rank, :default => "0"
  end

  class Vertex < LibEagle::Base
    empty_element
    attribute :x, :required => true
    attribute :y, :required => true
    attribute :curve, :default => "0"
  end

  class Pin < LibEagle::Base
    empty_element
    attribute :name, :required => true
    attribute :x, :required => true
    attribute :y, :required => true
    attribute :visible, :default => "both", :type => LibEagle::Types.PinVisible
    attribute :length, :default => "long", :type => LibEagle::Types.PinLength
    attribute :direction, :default => "io", :type => LibEagle::Types.PinDirection
    attribute :function, :default => "none", :type => LibEagle::Types.PinFunction
    attribute :swaplevel, :default => "0"
    attribute :rot, :default => "R0"
  end

  class Part < LibEagle::Base
    empty_element
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
    empty_element
    object :attribute
    attribute :part, :required => true
    attribute :gate, :required => true
    attribute :x, :required => true
    attribute :y, :required => true
    attribute :smashed, :default => "no", :type => LibEagle::Types.Bool
    attribute :rot, :default => "R0"
  end

  class Label < LibEagle::Base
    empty_element
    attribute :x, :required => true
    attribute :y, :required => true
    attribute :size, :required => true
    attribute :layer, :required => true
    attribute :font, :default => "proportional", :type => LibEagle::Types.TextFont
    attribute :ratio, :default => "8"
    attribute :rot, :default => "R0"
    attribute :xref, :default => "no", :type => LibEagle::Types.Bool
  end

  class Junction < LibEagle::Base
    empty_element
    attribute :x, :required => true
    attribute :y, :required => true
  end

  class Connect < LibEagle::Base
    empty_element
    attribute :gate, :required => true
    attribute :pin, :required => true
    attribute :pad, :required => true
    attribute :route, :default => "all", :type => LibEagle::Types.ContactRoute
  end

  class Technology < LibEagle::Base
    object :attribute
    attribute :name, :required => true
  end

  class Attribute < LibEagle::Base
    empty_element
    attribute :name, :required => true
    attribute :value
    attribute :x
    attribute :y
    attribute :size
    attribute :layer
    attribute :font, :type => LibEagle::Types.TextFont
    attribute :ratio
    attribute :rot, :default => "R0"
    attribute :display, :default => "value", :type => LibEagle::Types.AttributeDisplay
    attribute :constant, :default => "no", :type => LibEagle::Types.Bool
  end

  class Pinref < LibEagle::Base
    empty_element
    attribute :part, :required => true
    attribute :gate, :required => true
    attribute :pin, :required => true
  end

  class Contactref < LibEagle::Base
    empty_element
    attribute :element, :required => true
    attribute :pad, :required => true
    attribute :route, :default => "all", :type => LibEagle::Types.ContactRoute
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
    object :symbol
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
    object :library
  end

  class Connects < LibEagle::Base
    object :connect
  end

  class Technologies < LibEagle::Base
    object :technology
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
    object :pass
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
    empty_element
    attribute :alwaysvectorfont, :type => LibEagle::Types.Bool
    attribute :verticaltext, :type => LibEagle::Types.VerticalText
  end

  class Designrules < LibEagle::Base
    object :description
    object :param
    attribute :name, :required => true
  end

  class Grid < LibEagle::Base
    empty_element
    attribute :distance
    attribute :unitdist, :type => LibEagle::Types.GridUnit
    attribute :unit, :type => LibEagle::Types.GridUnit
    attribute :style, :default => "lines", :type => LibEagle::Types.GridStyle
    attribute :multiple, :default => "0"
    attribute :display, :default => "no", :type => LibEagle::Types.Bool
    attribute :altdistance
    attribute :altunitdist, :type => LibEagle::Types.GridUnit
    attribute :altunit, :type => LibEagle::Types.GridUnit
  end

  class Layer < LibEagle::Base
    empty_element
    attribute :number, :required => true
    attribute :name, :required => true
    attribute :color, :required => true
    attribute :fill, :required => true
    attribute :visible, :default => "yes"
    attribute :active, :default => "yes"
  end

  class CClass < LibEagle::Base
    change_element_name "class"
    object :clearance
    attribute :number, :required => true
    attribute :name, :required => true
    attribute :width, :default => "0"
    attribute :drill, :default => "0"
  end

  class Clearance < LibEagle::Base
    empty_element
    attribute :class, :required => true
    attribute :value, :default => "0"
  end

  class Description < LibEagle::Base
    text_content
    attribute :language
  end

  class Param < LibEagle::Base
    empty_element
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
    empty_element
    attribute :hash, :required => true
  end
end