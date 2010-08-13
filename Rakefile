require 'rubygems'
require 'bundler'
Bundler.setup :default, :rake
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "noodle"
  gem.summary = %Q{Use bundler to get your .NET assembly dependencies}
  gem.description = %Q{Use bundler to get your .NET assembly dependencies.}
  gem.email = "maburke@sep.com"
  gem.homepage = "http://github.com/spraints/noodle"
  gem.authors = ["Matt Burke"]
  gem.add_development_dependency 'jeweler'
  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'rspec'
  gem.add_dependency 'rake'
  gem.add_dependency 'bundler', '>= 1.0.0.rc.3'
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
