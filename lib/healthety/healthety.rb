module Healthety
  extend self

  def workers(&block)
    @workers = []
    @threads = []

    instance_eval(&block)

    start
  end

  def server(server)
    @server = server
  end

  def port(port)
    @port = port
  end

  def worker(name, &block)
    @workers << Worker.new(name, &block)
  end

  def start
    puts message
    transmission = Transmission.new(@server, @port)

    # Catch Ctrl-C and terminate all worker threads.
    trap("INT") { @threads.map(&:kill) }

    @workers.each do |worker|
      @threads << Thread.new do
        loop do
          worker.perform
          transmission.send(worker.name, worker.value, Time.now.utc)
          sleep worker.interval
        end
      end
    end

    @threads.map(&:join)
  end

  def message
    <<-EOM
=> Workers starting to send to #{@server}:#{@port}
=> Ctrl-C to stop
EOM
  end
end
