# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mm-stripper}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Richard Livsey"]
  s.date = %q{2010-06-14}
  s.email = %q{youremail@example.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["LICENSE", "Rakefile", "README.rdoc", "spec", "lib/mm-stripper.rb"]
  s.homepage = %q{http://github.com/rlivsey/mm-stripper}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Tiny plugin for MongoMapper to strip whitespace from strings before validation.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mongo_mapper>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<mongo_mapper>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<mongo_mapper>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
