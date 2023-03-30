require "support/spec_helper"

require "params_parser/rails_integration"
require "active_support"
require "action_controller/metal/strong_parameters"

describe ParamsParser::Parser do
  subject(:params_parser) { ParamsParser::Parser.new(config) }

  describe "#parse" do
    subject(:parsed) { params_parser.parse(parameters) }

    let(:config) { { configured_key: { } } }
    let(:parameters) { ActionController::Parameters.new(configured_key: double) }

    it "returns an ActionController::Parameters with permitted keys" do
      expect(parsed).to be_a ActionController::Parameters
      expect(parsed).to be_permitted
    end
  end
end
