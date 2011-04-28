# Ruby Worker

The Ruby Worker sends JSON wrapped data via UDP packets to a given host at a defined interval.

## Installation

```
$ gem install healthety
```

## Usage

``` ruby
require "healthety"

Healthety.workers do
  host "localhost"
  port 41234

  worker :load_average do
    interval 0.5
    # Gets load average with a system call (Mac OS X)
    value `w | head -n1 | cut -f4 -d":" | cut -f2 -d" "`.to_f
  end

  worker :random do
    interval 2
    value rand(10)
  end
end
```

That's all you need to do to define two different workers.

### Defining helpers

If you want to define some helper methods create a new module first. Note the `helpers` method at the end to include your module into the workers. In this case a new file called `connection_helper.rb` contains the MySQL connection handling.

``` ruby
require "mysql2"

module Healthety
  module ConnectionHelper
    def mysql
      @client ||= Mysql2::Client.new(:host => "localhost", :username => "root")
    end
  end

  helpers ConnectionHelper
end
```

In your workers you can now use the helper method. Since the MySQL connection gets saved into a class instance variable the connection gets established only once.

``` ruby
$:.unshift File.dirname(__FILE__)

require "healthety"
require "connection_helper"

Healthety.workers do
  host "localhost"
  port 41234

  worker :user_count do
    interval 5
    value mysql.query("SELECT COUNT(*) AS count FROM users").first["count"]
  end
end
```
