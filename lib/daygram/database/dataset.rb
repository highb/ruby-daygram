require 'json'

module Daygram
  class Database
    class Dataset
      def initialize(dataset)
        @data = dataset
      end

      def diary_fields
        [:date, :created, :updated, :content]
      end

      def to_string
        str = ""
        @data.each do |entry|
          str << "#{entry[:date]} | Created: #{entry[:created]} | Updated: #{entry[:updated]}\n"
          str << "#{entry[:content]}\n"
          str << "\n\n"
        end

        str
      end
      alias_method :to_s, :to_string

      def to_hash
        @data.to_hash(:date)
      end
      alias_method :to_h, :to_hash

      def to_array
        arr = []
        @data.each do |entry|
          row = []
          diary_fields.each do |field|
            row << entry[field]
          end
          arr << row
        end

        arr
      end
      alias_method :to_a, :to_array

      def to_json
        to_hash.to_json
      end
    end
  end
end
