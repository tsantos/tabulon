require 'rubygems'
require 'rake/gempackagetask'
require 'rake/clean'

GEM         = 'tabulon'
GEM_VERSION = '1.0.0'

spec = Gem::Specification.new do |s|
  s.author      = 'Tom Santos'
  s.email       = 'santos.tom@gmail.com'
  s.homepage    = "http://github.com/tsantos/tabulon"
  s.name        = GEM
  s.version     = GEM_VERSION

  s.summary     = "JRuby gem for bringing up a CSV viewing window"
  s.description = s.summary
  s.has_rdoc    = false
  s.platform    = Gem::Platform::RUBY

  s.add_dependency 'rake'
  s.files = %w[
    README.markdown
    bin/tabulon
    lib/tabulon-app.rb
    lib/tabulon.rb
  ]

  s.executables = ['tabulon']
end

Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end 

desc "Installs the gem locally"
task :install => :gem do |t|
  system "jgem install pkg/#{GEM}-#{GEM_VERSION}.gem"
end

# desc "Pushes the gem to gemcutter"
# task :push => :gem do |t|
  # system "gem push pkg/#{GEM}-#{GEM_VERSION}.gem"
# end

task :default => :gem

CLEAN.include 'pkg'
