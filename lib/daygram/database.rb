require "sequel"
require "daygram/database/dataset"

module Daygram
  class Database
    def initialize options = {}, config = {}
      @options = options
      @config = config
      if @options[:database]
        path = @options[:database]
      elsif config.to_h["database"]
        path = @config.to_h["database"]
      else
        raise "Must specify the database location"
      end

      unless File.exists? path
        raise "Specified DB does not exist: #{path}"
      end

      @DB = Sequel.sqlite(path)
    end

    def last n
      Dataset.new(@DB[:diary].order(:date).reverse.limit(n))
    end

    def latest
      last 1
    end

    def all
      Dataset.new(@DB[:diary].order(:date))
    end

    def day date
      Dataset.new(@DB[:diary].where("date == '#{date}'"))
    end
  end
end
