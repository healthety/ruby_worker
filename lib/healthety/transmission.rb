require "socket"
require "json"

module Healthety
  class Transmission
    def initialize(server, port)
      @server = server
      @port = port
      @host = Socket.gethostname
      @socket = UDPSocket.new
    end

    def send(name, value)
      data = {:name => name, :value => value, :host => @host}.to_json
      @socket.send(data, 0, @server, @port)
      $stdout << "#{name}: #{value}\n"
    end
  end
end
