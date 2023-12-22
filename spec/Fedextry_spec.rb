require "spec_helper"
require_relative "../lib/Fedextry"

RSpec.describe Fedextry::Rates do
  describe ".parse_response" do
    context "with a valid response" do
      it "returns parsed shipping rates" do
        response = File.read("spec/fixtures/valid_response.xml")
        rates = Fedextry::Rates.parse_response(Nokogiri::XML(response))

        expect(rates).to be_an(Array)
        expect(rates.first).to include(
          price: a_kind_of(Float),
          currency: a_kind_of(String),
          service_level: a_kind_of(Hash)
        )
      end
    end
  end
end
