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
  gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
  gem.add_development_dependency "yard", ">= 0"
  # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
end
Jeweler::GemcutterTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'yard'
YARD::Rake::YardocTask.new
