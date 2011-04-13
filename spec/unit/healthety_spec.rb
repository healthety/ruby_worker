require "spec_helper"

module Healthety
  describe Healthety do
    it "should start" do
      $stdout = StringIO.new
      Thread.any_instance.stubs(:join)
      UDPSocket.any_instance.stubs(:send)

      expect do
        Healthety.workers do
          host "127.0.0.1"
          port 8124

          worker :test do
            interval 0.5
            value rand(10)
          end
        end
      end.to be_true
    end
  end
end