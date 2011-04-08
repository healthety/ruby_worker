module Healthety
  class Worker
    attr_reader :name, :_interval, :_value

    def initialize(name, &block)
      @name = name.to_s
      @block = block
    end

    def interval(interval)
      @_interval ||= interval
    end

    def value(value)
      @_value = value.to_s
    end

    def perform
      instance_eval(&@block)
    end
  end
end
