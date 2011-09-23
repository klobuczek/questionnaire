# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "questionnaire/version"

Gem::Specification.new do |s|
  s.name        = "questionnaire"
  s.version     = Questionnaire::VERSION
  s.authors     = ["Leszek Kalwa"]
  s.email       = ["leszek.kalwa@gmail.com"]
  s.homepage    = "https://github.com/klobuczek/questionnaire/"
  s.summary     = %q{Questionnaire}
  s.description = %q{Builds forms of questions based on yml questionnairies file}

  s.rubyforge_project = "questionnaire"
  
  s.add_dependency "simple_form"
  
  s.add_development_dependency "rspec"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
