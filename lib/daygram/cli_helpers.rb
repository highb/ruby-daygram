module Daygram
  module CLIHelpers
    def format_output output
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

    def setup_db(options, config)
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

      Daygram::Database.new(db_path)
    end
  end
end
