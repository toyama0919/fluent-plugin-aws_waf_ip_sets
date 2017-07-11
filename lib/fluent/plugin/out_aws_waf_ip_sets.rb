module Fluent
  class AwsWafIPSetsOutput < TimeSlicedOutput
    Fluent::Plugin.register_output('aws_waf_ip_sets', self)
    config_param :ip_address_key, :string
    config_param :dos_threshold, :integer
    config_param :aws_access_key_id, :string, :default => nil
    config_param :aws_secret_access_key, :string, :default => nil
    config_param :aws_region, :string, :default => nil
    config_param :ip_set_id, :string
    config_param :ip_set_type, :enum, list: [:IPV4, :IPV6], :default => 'IPV4'
    config_param :white_list, :string, :default => '127.0.0.1'

    def initialize
      super
      require 'aws-sdk'
    end

    def configure(conf)
      super
      @white_list = @white_list.split(',')
      log.info("white list => #{@white_list}")
    end

    def start
      super
      options = {}
      options[:region] = @aws_region if @aws_region
      options[:access_key_id] = @aws_access_key_id if @aws_access_key_id
      options[:secret_access_key] = @aws_secret_access_key if @aws_secret_access_key
      Aws::WAFRegional::Client.new(options)
    end

    def shutdown
      super
    end

    def format(tag, time, record)
      [tag, time, record].to_msgpack
    end

    def write(chunk)
      counter = Hash.new{ |h,k| h[k] = 0 }
      chunk.msgpack_each do |(tag, time, record)|
        counter[record[ip_address_key]] += 1
      end

      counter.each do |ip_address, count|
        if @dos_threshold < count
          update_ip_set(ip_address)
        end
      end
    end

    private

    def get_change_token
      @client.get_change_token.change_token
    end

    def update_ip_set(ip_address)
      if @white_list.include?(ip_address)
        log.info("white list ip_address => [#{ip_address}]")
        return
      end

      updates = [
        {
          action: 'INSERT',
          ip_set_descriptor: {
            type: @ip_set_type,
            value: "#{ip_address}/32"
          }
        }
      ]

      begin
        resp = @client.update_ip_set({
          change_token: get_change_token,
          ip_set_id: @ip_set_id,
          updates: updates
        })
        log.info("INSERT block ip_address => [#{ip_address}]")
      rescue => e
        log.error("\n#{e.message}\n#{e.backtrace.join("\n")}")
      end
    end
  end
end
