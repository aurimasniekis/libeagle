# LibEagle [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/gcds/libeagle)

LibEagle is a library for __[Cadsoft Eagle PCB Design Software](http://www.cadsoftusa.com/eagle-pcb-design-software/product-overview/?language=en)__. Eagle uses xml based files. This library implements Eagle xml files and converts it to Objects and reverse.

## Requirements:
* Nokogiri
* HTMLEntities
* [Eagle PCB Design Software](http://www.cadsoftusa.com/eagle-pcb-design-software/product-overview/?language=en) __> 6.0 (only)__

## Installation:

### Bundler:

	gem 'libeagle'	

### Rubygems:

    $ gem install libeagle

## Usage:

The usage is really simple first you include gem in your file:

	require "libeagle"
	
### Parsing:

Parsing eagle files (schematic, board or library) or block of eagle elements (packages, devices, symbols and etc.) you have two options parse from file or string:

	eagle = LibEagle::Parser.parseFile(file_name)
	 => #<LibEagle::Eagle:0x007fd5ca956738>
	 
or string:

	eagle = LibEagle::Parser.parseXML("…")
	 => #<LibEagle::Eagle:0x007fd5ca956738>
	 

### Hand Crafting:

To Create eagle files with hands or dynamically. Just use as simple objects:

	eagle = LibEagle::Eagle.new
	# Create a drawing object
	eagle.object_drawing = LibEagle::Drawing.new
	
#### Setting attributes
	
	eagle.attribute_version = "6.0"
	
#### Setting object

	eagle.object_drawing = LibEagle::Drawing.new
	
### XML Saving:

After creating, parsing, editing if you want to save file use `.saveXML` will generate xml code of that object:

	
	eagle = LibEagle::Eagle.new
	eagle.attribute_version = "6.0"
	eagle.saveXML
	 => "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<!DOCTYPE eagle SYSTEM \"eagle.dtd\">\n<eagle version=\"6.0\">\n</eagle>\n"


## Todo:
1. Create API DOcs
2. Optimize source code

## Thank you:
*	__Martin DeMello__ (for pointing out how to optimize code)

## Contributing:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright (c) 2012 Aurimas Niekis Dual licensed under the MIT license and GPL license.

## Links:
* [rDoc](http://rdoc.info/github/gcds/libeagle/master/frames)
* [Cadsoft Eagle PCB Design Software](http://www.cadsoftusa.com/eagle-pcb-design-software/product-overview/?language=en)
