module Healthety
  class Worker
    attr_reader :name

    def initialize(name, &block)
      @name = name.to_s
      @block = block
    end

    def interval(interval = nil)
      @interval = interval || @interval
    end

    def value(value = nil)
      @value = value || @value
    end

    def perform
      instance_eval(&@block)
    end
  end
end
