require "healthety"
require "rspec"

RSpec.configure do |config|
  include Healthety

  config.mock_with :mocha
end
