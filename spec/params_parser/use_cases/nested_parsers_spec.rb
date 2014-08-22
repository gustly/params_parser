require "support/spec_helper"

describe "Nested Parsers" do
  subject(:parser) { ParamsParser::Parser.new(config) }

  let(:config) do
    {
      a: { transform: :upcase.to_proc },
      b: {
        transform: ParamsParser::Parser.new(
            c: { default: "c" },
            d: { transform: :upcase.to_proc }
          ).to_proc
      }
    }
  end

  let(:params) do
    {
      a: "a",
      b: {
        d: "d"
      }
    }
  end

  specify do
    expect(parser.parse(params)).to eq({
      a: "A",
      b: {
        c: "c",
        d: "D"
      }
    })
  end
end
