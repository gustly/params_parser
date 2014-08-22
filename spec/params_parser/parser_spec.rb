require "support/spec_helper"

describe ParamsParser::Parser do
  subject(:params_parser) { ParamsParser::Parser.new(config) }

  describe "#to_proc" do
    let(:config) { { } }
    specify { expect(params_parser.to_proc).to eq(params_parser.public_method(:parse)) }
  end

  describe "#parse" do
    subject(:parsed) { params_parser.parse(parameters) }

    describe "limiting keys in the parameters" do
      let(:config) { { configured_key: { } } }
      let(:parameters) { { not_configured_key: double } }

      it "discards unconfigured keys" do
        expect(parsed.keys).to_not include(:not_configured_key)
      end
    end

    describe "mapping keys" do
      let(:config) { { a: { map_to: :b } } }
      let(:parameters) { { a: double(:value_at_a) } }

      specify do
        expect(parsed).to_not have_key(:a)
        expect(parsed[:b]).to eq(parameters[:a])
      end
    end

    describe "transforms" do
      context "the key has a transform" do
        let(:config) { { int: { transform: :to_i.to_proc } } }
        let(:parameters) { { int: "10" } }

        it "transforms the value using the transform callable" do
          expect(parsed[:int]).to eq(10)
        end
      end
    end

    describe "defaults" do
      context "a default is not specified" do
        let(:config) { { key_without_default: { } } }

        context "the key is not in the parameters" do
          let(:parameters) { { } }

          it "does not add the key to the parameters" do
            expect(parsed).to_not include(:key_without_default)
          end
        end
      end

      context "a default is specified" do
        let(:default) { double(:default) }
        let(:config) { { key_with_default: { default: default } } }

        context "the key is not in the parameters" do
          let(:parameters) { { } }

          it "sets the parameter to the default" do
            expect(parsed[:key_with_default]).to eq(default)
          end
        end

        context "the key is in the parameters, but falsey" do
          let(:parameters) { { key_with_default: nil } }

          it "sets the parameter to the default" do
            expect(parsed[:key_with_default]).to eq(default)
          end
        end

        context "the key is in the parameters, but the transform returns a falsey value" do
          let(:config) { { key_with_default: { default: default, transform: proc { nil } } } }
          let(:parameters) { { key_with_default: double(:anything) } }

          it "sets the parameter to the default" do
            expect(parsed[:key_with_default]).to eq(default)
          end
        end
      end
    end
  end
end
