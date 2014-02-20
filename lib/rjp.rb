require "rjp/version"
require 'rjp/traversable'
require 'json'

module Rjp
  def self.new(*args)
    Parser.new(*args)
  end

  class Parser
    def initialize(json_str)
      @raw = json_str
    end

    def extract(*keys, &block)
      json.traverse(*keys, &block)
    end

    def to_h
      json
    end

    def json
      @json ||= Traversable.new(JSON.parse @raw)
    end
  end
end
