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

    def send(name, value)
      data = {
        :value => value,
        :name => name,
        :date => Time.now.to_f,
        :host => @worker_host
      }.to_json

      @socket.send(data, 0, @host, @port)
      $stdout << "#{name}: #{value}\n"
    end
  end
end
