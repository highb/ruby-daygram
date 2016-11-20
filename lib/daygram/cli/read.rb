module Daygram
  module CLISubcommands
    class Read < Thor
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
      type: :numeric, default: 5
      argument :number, :type => :numeric, :desc => "The number to start counting"
      desc "read", %(Read the Daygram journal.)
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
          require 'pry'
          binding.pry
          output = db.last()
        elsif task == 'latest'
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
end
