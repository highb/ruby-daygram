# frozen_string_literal: true

require "fileutils"
require "thor"
require "thor/actions"
require "thor_plus/actions"
require "runcom"
require "json"
require "pp"
require "terminal-table"

module Daygram
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
    method_option :all,
                  aliases: "a",
                  desc: "Read all entries.",
                  type: :boolean, default: false
    method_option :latest,
                  desc: "Read latest entry.",
                  type: :boolean, default: false
    method_option :last,
                  desc: "Read last N entries.",
                  type: :boolean, default: true
    method_option :format, :type => :string, :aliases => ['-f']

    def read task = nil
      config = self.class.configuration

      if options[:database]
        db_path = options[:database]
      elsif config.to_h["database"]
          db_path = config.to_h["database"]
      else
        say "Must specify the database location"
        return
      end

      unless File.exists? db_path
        say "Specified DB does not exist: #{db_path}"
        return
      end

      db = Daygram::Database.new(db_path)

      if task == 'all'
        output = db.all
      elsif task == 'last'
        output = db.last(5)
      else # or latest
        output = db.latest
      end

      if options[:format] == 'hash'
        pp output.to_hash
      elsif options[:format] == 'json'
        pp output.to_json
      elsif options[:format] == 'table'
        say Terminal::Table.new :title => "Daygram Diary", :headings => output.diary_fields, :rows => output.to_array
      else
        say output.to_s
      end
    end
  end
end
