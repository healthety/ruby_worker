require "socket"
require "json"

module Healthety
  class Transmission
    def initialize(host, port)
      @host = host
      @port = port
      @worker_host = Socket.gethostname
      @socket = UDPSocket.new
    end

    def send(name, value, created_at)
      data = {
        :name => name, :value => value,
        :created_at => created_at, :host => @worker_host
      }.to_json
      @socket.send(data, 0, @host, @port)
      $stdout << "#{name}: #{value}\n"
    end
  end
end
