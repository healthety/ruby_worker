# Ruby Worker

The Ruby Worker sends JSON data via UDP packets to a given host at a defined interval.

### Installation

    gem install healthety

### Usage

    require "healthety"

    Healthety.workers do
      host "127.0.0.1"
      port 8124

      worker :load_average do
        interval 0.5
        value rand(10)
      end

      worker :memory do
        interval 2
        value rand(10)
      end
    end
