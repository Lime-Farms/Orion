module Orion
  class Command
    def self.descendants
      ObjectSpace.each_object(Class).select do |klass|
        klass < self
      end
    end
  end
end
