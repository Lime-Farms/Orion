module Orion
  class Command
    def self.descendants
      ObjectSpace.each_object(Class).select do |klass|
        klass < self
      end
    end

    def initialize(key: nil)
      @key = key
    end

    def run
      raise NotImplementedError, "this command is not implemented"
    end
  end
end
