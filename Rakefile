require 'rubygems'
require 'bundler'
Bundler.setup :default, :rake
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "noodle"
  gem.summary = %Q{TODO: one-line summary of your gem}
  gem.description = %Q{TODO: longer description of your gem}
  gem.email = "maburke@sep.com"
  gem.homepage = "http://github.com/spraints/noodle"
  gem.authors = ["Matt Burke"]
  gem.add_development_dependency "rspec", ">= 1.2.9"
  gem.add_development_dependency "yard", ">= 0"
  # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
end
Jeweler::GemcutterTasks.new

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
