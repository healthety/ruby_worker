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
        # Get load average with a system call (OS X)
        value `w | head -n1 | cut -f4 -d":" | cut -f2 -d" "`.to_f
      end

      worker :memory do
        interval 2
        value rand(10)
      end
    end
