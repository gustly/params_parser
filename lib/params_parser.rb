module ParamsParser
  module Transforms
    ID = lambda { |x| x }.freeze
  end

  class Parser
    def initialize(config)
      @config = Hash[config.map do |(key, param_config)|
        [key, ParamConfig.new(key, param_config)]
      end]
    end

    def parse(params)
      params.class.new.tap do |parsed_params|
        config.each do |(key, param_config)|
          if params[key]
            parsed_params[param_config.key] = param_config.transform.call(params[key])
          end

          parsed_params[param_config.key] ||= param_config.default if param_config.has_default?
        end
      end
    end

    def to_proc
      public_method(:parse)
    end

    private

    attr_reader :config
  end

  class ParamConfig
    def initialize(key, config)
      @config = config
      @transform = config.fetch(:transform, Transforms::ID)
      @key = config.fetch(:map_to, key)
      @default = config[:default]
    end

    attr_reader :transform
    attr_reader :key
    attr_reader :default

    def has_default?
      config.has_key?(:default)
    end

    private

    attr_reader :config
  end
end
