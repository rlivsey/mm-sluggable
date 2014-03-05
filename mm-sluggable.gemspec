# -*- encoding: utf-8 -*-
# stub: mm-sluggable 0.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "mm-sluggable"
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Richard Livsey"]
  s.date = "2014-03-05"
  s.email = "richard@livsey.org"
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["LICENSE", "Rakefile", "README.rdoc", "lib/mm-sluggable.rb"]
  s.homepage = "http://github.com/rlivsey/mm-sluggable"
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.11"
  s.summary = "Tiny plugin for MongoMapper to cache a slugged version of a field"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mongo_mapper>, [">= 0.9.0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<mongo_mapper>, [">= 0.9.0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<mongo_mapper>, [">= 0.9.0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
