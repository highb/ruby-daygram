require "sequel"
require "daygram/database/dataset"

module Daygram
  class Database
    def initialize path, options = {}, config = {}
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
  end
end
