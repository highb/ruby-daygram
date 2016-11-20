# frozen_string_literal: true

require "fileutils"
require "thor"
require "thor/actions"
require "thor_plus/actions"
require "runcom"
require "json"
require "pp"
require "terminal-table"
require "daygram/cli_helpers"

module Daygram
  class Read < Thor
    include Thor::Actions
    include ThorPlus::Actions
    include Daygram::CLIHelpers

    def initialize args = [], options = {}, config = {}
      super args, options, config
    end

    def self.configuration
      Runcom::Configuration.new file_name: Daygram::Identity.file_name
    end

    class_option :format, :type => :string, :aliases => ['-f']

    desc "all", %(Read all entries.)
    def all
      db = Daygram::Database.new(options, self.class.configuration)
      say db.all.format_output(options)
    end

    desc "latest", %(Read latest entry.)
    def latest
      db = Daygram::Database.new(options, self.class.configuration)
      say db.latest.format_output(options)
    end

    desc "last N", %(Read last N entries.)
    def last n=5
      db = Daygram::Database.new(options, self.class.configuration)
      say db.last(n).format_output(options)
    end

    desc "day YYYY-MM-DD", %(Read YYYY-MM-DD entry.)
    def day date
      db = Daygram::Database.new(options, self.class.configuration)
      say db.day(date).format_output(options)
    end
  end

  # The Command Line Interface (CLI) for the gem.
  class CLI < Thor
    include Thor::Actions
    include ThorPlus::Actions

    package_name Daygram::Identity.version_label

    def self.configuration
      Runcom::Configuration.new file_name: Daygram::Identity.file_name
    end

    def initialize args = [], options = {}, config = {}
      super args, options, config
    end

    class_option :database, :type => :string, :aliases => ['-d', '-db']

    desc "config", %(Manage gem configuration ("#{configuration.computed_path}").)
    map %w[c config -c --config] => :config
    method_option :edit,
                  aliases: "-e",
                  desc: "Edit gem configuration.",
                  type: :boolean, default: false
    method_option :info,
                  aliases: "-i",
                  desc: "Print gem configuration.",
                  type: :boolean, default: false

    def config
      path = self.class.configuration.computed_path

      unless File.exists? path
        FileUtils.touch(path)
      end

      if options.edit? then `#{editor} #{path}`
      elsif options.info? then say(path)
      else help(:config)
      end
    end

    desc "version", "Show gem version."
    map %w[v version -v --version] => :version
    def version
      say Identity.version_label
    end

    desc "help COMMAND", "Show this message or get help for a command."
    map %w[h help -h --help] => :help
    def help task = nil
      say and super
    end

    desc "read", %(Read the Daygram journal.)
    subcommand "read", Read
  end
end
