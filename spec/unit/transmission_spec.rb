require "spec_helper"

module Healthety
  describe Transmission do
    it "should send UDP packets" do
      $stdout = StringIO.new
      transmission = Transmission.new("127.0.0.1", 8124)

      transmission.instance_variable_get(:@socket).stubs(:send)
      transmission.expects(:send).at_least_once

      transmission.send("test", 5)
    end
  end
end
