module ParamsParser
  module RailsIntegration
    def parse(params)
      permit(super(permit(params)))
    end

    private

    def permit(params)
      case params
      when ActionController::Parameters
        params.permit(config.keys)
      else
        params
      end
    end
  end

  Parser.prepend RailsIntegration
end
