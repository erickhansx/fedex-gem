# frozen_string_literal: true

require "httparty"
require "nokogiri"
require "dotenv"
require "erb"
require "json"

require_relative "Fedextry/version"

module Fedextry
  class Rates # rubocop:disable Style/Documentation
    def self.get(credentials, quote_params)
      url = "https://wsbeta.fedex.com:443/xml"
      body = build_request_body(credentials, quote_params)
      response = HTTParty.post(url, body: body)
      parse_response(response)
    end

    def self.build_request_body(credentials, quote_params)
      template_path = File.expand_path("templates/fedex_rate_request.xml.erb", __dir__)
      template = File.read(template_path)
      ERB.new(template).result(binding)
    end

    def self.parse_response(response) # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
      xml_data = response.is_a?(Nokogiri::XML::Document) ? response : Nokogiri::XML(response.body)

      rates = xml_data.xpath("//*[local-name()='RateReplyDetails']").map do |detail|
        service_type = detail.at_xpath("*[local-name()='ServiceType']").text

        rate_detail = detail.xpath("*[local-name()='RatedShipmentDetails']/*[local-name()='ShipmentRateDetail']").find do |rd|
          rd.at_xpath("*[local-name()='TotalNetCharge']/*[local-name()='Currency']").text == "MXN"
        end

        next unless rate_detail

        price = rate_detail.at_xpath("*[local-name()='TotalNetCharge']/*[local-name()='Amount']").text.to_f
        currency = rate_detail.at_xpath("*[local-name()='TotalNetCharge']/*[local-name()='Currency']").text

        service_token = service_type.gsub(/\s+/, "_").upcase
        {
          price: price,
          currency: currency,
          service_level: {
            name: service_type,
            token: service_token
          }
        }
      end

      # Filter out any entries with missing data
      rates.select { |rate| (rate[:price]).positive? && !rate[:currency].empty? && !rate[:service_level][:name].empty? }
    rescue Nokogiri::XML::SyntaxError => e
      { error: "Failed to parse XML: #{e.message}" }
    end
  end
end
