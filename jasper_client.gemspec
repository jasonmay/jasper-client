# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{jasper-client}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andrew Libby"]
  s.date = %q{2010-11-03}
  s.default_executable = %q{walker}
  s.description = %q{Client for JasperServer}
  s.email = %q{alibby@xforty.com}
  s.executables = ["walker"]

  s.add_dependency("rest-client", "~> 1.6.6")
  s.add_dependency("nokogiri", "~> 1.5.5")

  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    "COPYING",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/walker",
     "lib/jasper_client/http_multipart.rb",
     "lib/jasper_client/jasper_client.rb",
     "lib/jasper_client/string.rb",
     "test/helper.rb",
     "test/test_jasper_client.rb"
  ]
  s.homepage = %q{http://github.com/alibby/jasper-client}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Client for JasperServer}
  s.test_files = [
    "test/helper.rb",
     "test/test_jasper_client.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
