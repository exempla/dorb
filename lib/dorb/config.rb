module DORB
  module Config
    attr_writer :client_id, :api_key

    def client_id
      if @client_id
        @client_id
      else
        raise DORB::ConfigurationError.new \
          "Cannot complete request. Please set client_id with DORB::Config.setup first!"
      end
    end

    def api_key
      if @api_key
        @api_key
      else
        raise DORB::ConfigurationError.new \
          "Cannot complete request. Please set api_key with DORB::Config.setup first!"
      end
    end

    def setup opts={}
      opts.map do |k,v|
        send("#{k}=", v)
      end
    end

#    def method_missing(meth, *args, &blk)
#      const = meth.to_s.upcase
#      DORB.const_set(const, args.first) unless DORB.const_defined? const
#    end

    extend self
  end
end
