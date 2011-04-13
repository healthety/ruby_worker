require "spec_helper"

module Healthety
  describe Worker do
    before(:each) do
      @block = Proc.new { interval 0.5; value 10 }
      @worker = Worker.new(:test, &@block)
    end

    it "should initialize" do
      @worker.name.should eq("test")
      @worker.instance_variable_get(:@block).should be(@block)
    end

    it "should perform" do
      @worker.perform

      @worker.interval.should eq(0.5)
      @worker.value.should eq(10)

      @worker.interval 0.7
      @worker.value 11

      @worker.interval.should eq(0.7)
      @worker.value.should eq(11)
    end
  end
end