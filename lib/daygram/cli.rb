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

    desc "[a]ll", %(Read all entries.)
    def all
      db = setup_db(options, self.class.configuration)
      format_output db.all
    end

    desc "[la]test", %(Read latest entry.)
    def latest
      db = setup_db(options, self.class.configuration)
      format_output db.latest
    end

    desc "[l]ast", %(Read last N entries.)
    def last n
      db = setup_db(options, self.class.configuration)
      format_output db.last(n)
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

    desc "[c]onfig", %(Manage gem configuration ("#{configuration.computed_path}").)
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

    desc "[v]ersion", "Show gem version."
    map %w[v version -v --version] => :version
    def version
      say Identity.version_label
    end

    desc "[h]elp COMMAND", "Show this message or get help for a command."
    map %w[h help -h --help] => :help
    def help task = nil
      say and super
    end

    desc "[r]ead", %(Read the Daygram journal.)
    map %w[r read] => :read
    subcommand "read", Read
  end
end
