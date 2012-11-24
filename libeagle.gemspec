# -*- encoding: utf-8 -*-
require File.expand_path('../lib/libeagle/version', __FILE__)
Gem::Specification.new do |gem|
  gem.authors       = ["Aurimas Niekis"]
  gem.email         = ["aurimas.niekis@gmail.com"]
  gem.description   = %q{CadSoft Eagle Ruby Library}
  gem.summary       = %q{This gem provides functionality to manage CadSoft Eagle Files}
  gem.homepage      = "http://www.gcds.lt"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "libeagle"
  gem.require_paths = ["lib"]
  gem.version       = Libeagle::VERSION
  gem.add_dependency('nokogiri')
  gem.add_dependency('htmlentities')
end
