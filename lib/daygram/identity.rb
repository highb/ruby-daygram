# frozen_string_literal: true

module Daygram
  # Gem identity information.
  module Identity
    def self.name
      "daygram"
    end

    def self.label
      "Daygram"
    end

    def self.version
      "0.1.5"
    end

    def self.version_label
      "#{label} #{version}"
    end

    def self.file_name
      ".#{name}rc"
    end
  end
end
