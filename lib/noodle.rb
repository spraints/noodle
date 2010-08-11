
module Noodle
  module Rake

  class NoodleTask < ::Rake::TaskLib
    # The name of the rake task to generate.
    # Defaults to `:noodle`.
    attr_accessor :name

    # An array of bundler groups that reference the required dlls.
    # Use an empty array for all groups.
    # Defaults to all groups.
    attr_accessor :groups

    # The destination directory.
    # Defaults to `'lib'`.
    attr_accessor :outdir

    # Whether to copy everything into one directory or not.
    # If this is true, all gem lib directories will be combined in {#outdir}.
    # If this is false, each gem lib will be stored in a separate subdirectory of {#outdir}.
    # Defaults to `false`.
    attr_accessor :merge

    # Set {#merge} to `true`.
    def merge! ; @merge = true ; end

    def initialize name = :noodle
      @name   = name
      @groups = []
      @outdir = 'lib'
      @merge  = false
      yield self if block_given?
      define
    end

    def define # :nodoc:
      unless ::Rake.application.last_comment
        desc "Updates .NET dependencies in '#{outdir}'"
      end
      task name => "#{name}:update"

      desc "Copies .NET dependencies to '#{outdir}'"
      task "#{name}:copy" do
        specs = groups.any? ? Bundler.definition.specs_for(groups) : Bundler.environment.requested_specs
        specs.each do |spec|
          next if spec.name == 'bundler'
          spec.load_paths.each do |path|
            dest_path = dest_for(spec)
            FileUtils.mkdir_p dest_path
            FileUtils.cp_r path, dest_path, :verbose => true
          end
        end
      end

      def dest_for spec
        dest = outdir.dup
        dest << "/#{spec.name}-#{spec.version}" unless merge
        File.expand_path(dest)
      end

      desc "Cleans '#{outdir}'"
      task "#{name}:clean" do
        FileUtils.rm_rf outdir, :verbose => true
      end

      desc "Updates .NET dependencies in '#{outdir}'"
      task "#{name}:update" => ["#{name}:clean", "#{name}:copy"]
    end
  end

  end
end
