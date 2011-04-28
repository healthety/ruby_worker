require "spec_helper"

module Healthety
  module TestHelper
    def test; end
  end

  describe Healthety do
    $stdout = StringIO.new
    Thread.any_instance.stubs(:join)
    UDPSocket.any_instance.stubs(:send)

    it "should start" do
      expect do
        Healthety.workers do
          server "127.0.0.1"
          port 41234

          worker :test do
            interval 0.5
            value rand(10)
          end
        end
      end.to be_true
    end

    it "should inclde helpers" do
      Healthety.helpers TestHelper

      expect do
        Healthety.workers do
          server "127.0.0.1"
          port 41234

          worker :test do
            interval 0.5
            value test
          end
        end
      end.to be_true
    end
  end
end