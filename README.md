# Ruby Worker

The Ruby Worker sends JSON wrapped data via UDP packets to a given server at a defined interval.

## Installation

    $ gem install healthety

## Usage

    require "healthety"

    Healthety.workers do
      server "127.0.0.1"
      port 41234

      worker :load_average do
        interval 0.5
        # Gets load average with a system call (Mac OS X)
        value `w | head -n1 | cut -f4 -d":" | cut -f2 -d" "`.to_f
      end

      worker :memory do
        interval 2
        value rand(10)
      end
    end

### Defining helpers

If you want to define some helper methods create a new module first. Note the <tt>helpers</tt> method at the end to include your module into the workers. In this case a new file called <tt>connection_helper.rb</tt> contains the MySQL connection handling.

    require "mysql2"

    module Healthety
      module ConnectionHelper
        def mysql
          @client ||= Mysql2::Client.new(:host => "localhost", :username => "root")
        end
      end

      helpers ConnectionHelper
    end

In your workers you can now use the helper method. Since the MySQL connection gets saved into a class instance variable the connection gets established only once.

    $:.unshift File.dirname(__FILE__)

    require "healthety"
    require "connection_helper"

    Healthety.workers do
      server "127.0.0.1"
      port 41234

      worker :user_count do
        interval 5
        value mysql.query("SELECT COUNT(*) AS count FROM users").first["count"]
      end
    end
