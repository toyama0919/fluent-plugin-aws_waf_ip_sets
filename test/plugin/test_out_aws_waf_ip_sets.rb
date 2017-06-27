require 'helper'
class AwsWafIPSetsOutputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  DEFAULT_CONFIG = %[

  ]

  def create_driver(conf = DEFAULT_CONFIG)
    config = %[
      apikey testkey
      buffer_path tmp/buffer
    ] + conf

    Fluent::Test::BufferedOutputTestDriver.new(Fluent::AwsWafIPSetsOutput) do
      def write(chunk)
        chunk.instance_variable_set(:@key, @key)
        super(chunk)
      end
    end.configure(config)
  end

  def test_configure
    d = create_driver

    {
      :@apikey => 'testkey',
      :@use_ssl => true,
      :@auto_create_table => true,
      :@buffer_type => 'file' 
    }.each { |k, v|
      assert_equal(d.instance.instance_variable_get(k), v)
    }
  end
end
