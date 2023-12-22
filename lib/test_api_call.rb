# frozen_string_literal: true

require "dotenv"
Dotenv.load
require_relative "Fedextry"
require "erb"

credentials = {
  key: "bkjIgUhxdghtLw9L",
  password: "6p8oOccHmDwuJZCyJs44wQ0Iw",
  account_number: "510087720",
  meter_number: "119238439",
  language_code: "es",
  locale_code: "MX"
}

quote_params = {
  address_from: {
    zip: "64000",
    country: "MX"
  },
  address_to: {
    zip: "64000",
    country: "MX"
  },
  parcel: {
    length: 25.0,
    width: 28.0,
    height: 46.0,
    distance_unit: "cm",
    weight: 6.5,
    mass_unit: "kg"
  }
}

puts "Sending request to FedEx API..."

begin
  rates = Fedextry::Rates.get(credentials, quote_params)
  puts "Rates response received:"
  puts rates
rescue StandardError => e
  puts "An error occurred: #{e.message}"
end
