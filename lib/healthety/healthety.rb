module Healthety
  extend self

  def workers(&block)
    @workers = []
    @threads = []

    instance_eval(&block)

    start
  end

  def host(host)
    @host = host
  end

  def port(port)
    @port = port
  end

  def worker(name, &block)
    @workers << Worker.new(name, &block)
  end

  # Makes the methods defined in the helper modules given in `extensions`
  # available to the workers.
  def helpers(*extensions)
    Worker.class_eval { include(*extensions) } if extensions.any?
  end

  def start
    puts message
    transmission = Transmission.new(@host, @port)

    # Catch Ctrl-C and terminate all worker threads.
    trap("INT") { @threads.map(&:kill) }

    @workers.each do |worker|
      @threads << Thread.new do
        loop do
          worker.perform
          transmission.send(worker.name, worker.value)
          sleep worker.interval
        end
      end
    end

    @threads.map(&:join)
  end

  def message
    <<-EOM
=> Workers sending to #{@host}:#{@port}
=> Ctrl-C to stop
EOM
  end
end
