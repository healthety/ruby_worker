require "spec_helper"

describe Worker do
  it "should initialize" do
    class TestStats < Healthety::API
      host "127.0.0.1"
      port 8124
    end

    worker "test" do
      interval 0.5
      value 100
    end
  end
end
