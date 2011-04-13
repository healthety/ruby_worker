require "socket"
require "json"

module Healthety
  class Transmission
    def initialize(host, port)
      @host = host
      @port = port
      @socket = UDPSocket.new
    end

    def send(name, value)
      data = {:name => name, :value => value}.to_json
      @socket.send(data, 0, @host, @port)
      $stdout << "#{name}: #{value}\n"
    end
  end
end
