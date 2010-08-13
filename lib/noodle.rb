require 'rake/tasklib'
require 'bundler'
module Noodle
  module Rake

  # Rake tasks for setting up .NET dependencies.
  #
  # Four tasks are defined:
  # * noodle:copy - copy the lib directories from the gems to the local project.
  # * noodle:clean - remove the local lib directory.
  # * noodle:update - clean, then copy.
  # * noodle - alias of noodle:copy.
  #
  # @example
  #   Noodle::Rake::NoodleTask.new :customname do |n|
  #     n.groups << :dotnet # only use the bundler :dotnet group
  #     n.outdir = 'someplace-other-than-lib'
  #     n.merge! # merge all the libs together
  #   end
  class NoodleTask < ::Rake::TaskLib
    # The name of the rake task to generate.
    #
    # Defaults to :noodle.
    # @return [String]
    attr_accessor :name

    # An array of bundler groups that reference the required dlls.
    # Use an empty array for all groups.
    #
    # Defaults to all groups.
    # @return [Array]
    attr_accessor :groups

    # The destination directory.
    #
    # Defaults to 'lib'.
    # @return [String]
    attr_accessor :outdir

    # Whether to copy everything into one directory or not.
    # If this is true, all gem lib directories will be combined in {#outdir}.
    # If this is false, each gem lib will be stored in a separate subdirectory of {#outdir}.
    # You can also set this by calling `merge!`
    #
    # Defaults to false.
    # @return [Boolean]
    attr_accessor :merge

    # Sets {#merge} to true.
    # @return [void]
    def merge!
      @merge = true
    end

    # Define noodle's rake tasks.
    # @yield [noodle]
    # @yieldparam [NoodleTask] noodle the noodle task generator.
    def initialize name = :noodle
      @name   = name
      @groups = []
      @outdir = 'lib'
      @merge  = false
      yield self if block_given?
      define
    end

    private
    def define
      unless ::Rake.application.last_comment
        desc "Copies .NET dependencies in '#{outdir}'"
      end
      task name => "#{name}:copy"

      desc "Copies .NET dependencies to '#{outdir}'"
      task "#{name}:copy" do
        specs = groups.any? ? Bundler.definition.specs_for(groups) : Bundler.environment.requested_specs
        specs.each do |spec|
          next if spec.name == 'bundler'
          spec.load_paths.each do |path|
            dest_path = dest_for(spec)
            FileUtils.mkdir_p dest_path
            FileUtils.cp_r "#{path}/.", dest_path, :verbose => true
          end
        end
      end

      desc "Cleans '#{outdir}'"
      task "#{name}:clean" do
        FileUtils.rm_rf outdir, :verbose => true
      end

      desc "Updates .NET dependencies in '#{outdir}'"
      task "#{name}:update" => ["#{name}:clean", "#{name}:copy"]
    end

    def dest_for spec
      dest = outdir.dup
      dest << "/#{spec.name}-#{spec.version}" unless merge
      File.expand_path(dest)
    end
  end

  end
end
