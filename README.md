Fedextry Gem - Usage Guide
Introduction
Fedextry is a Ruby gem designed to interact with FedEx's API, allowing users to easily retrieve shipping rate quotes. This guide explains how to use the gem to get rates by running the test_api_call.rb script.

Installation
Before using the gem, ensure you have Ruby installed on your system. You also need to have the following dependencies:

HTTParty
Nokogiri
Dotenv
ERB
JSON
You can install these dependencies using Ruby's package manager, gem. For example:

bash
Copy code
gem install httparty nokogiri dotenv
Setting Up
Clone the Repository: Clone or download the Fedextry repository to your local machine.

Configure Environment Variables: Set up your FedEx API credentials in a .env file at the root of your project. This file should include your key, password, account number, and meter number.

Example .env file:

makefile
Copy code
FEDEX_KEY=your_key
FEDEX_PASSWORD=your_password
FEDEX_ACCOUNT_NUMBER=your_account_number
FEDEX_METER_NUMBER=your_meter_number
Load Dependencies: Ensure that your script loads all required dependencies, as shown in the test_api_call.rb file.

Usage
To get rates from FedEx using the Fedextry gem, follow these steps:

Set Up Credentials and Quote Parameters: In test_api_call.rb, configure your FedEx credentials and quote parameters. The quote parameters should include the origin and destination addresses, as well as parcel dimensions and weight.

Run the Script: Execute the test_api_call.rb script to send a request to FedEx and receive rate quotes. Run the script from the command line:

bash
Copy code
ruby test_api_call.rb
View Results: The script will output the rate quotes in JSON format, displaying the price, currency, and service level for each shipping option.

Example Response
The response will look something like this (in JSON format):

json
Copy code
``[
  {
    "price": 218.05,
    "currency": "MXN",
    "service_level": {
      "name": "Standard Overnight",
      "token": "STANDARD_OVERNIGHT"
    }
  },
  {
    "price": 139.08,
    "currency": "MXN",
    "service_level": {
      "name": "Fedex Express Saver",
      "token": "FEDEX_EXPRESS_SAVER"
    }
  }
]``
Notes
Ensure your API credentials are correct and have the necessary permissions to access FedEx's rate services.
The script's output depends on the current data provided by FedEx's API, which may vary based on the request parameters and FedEx's pricing at the time of the request.
Contributing
Contributions to the Fedextry gem are welcome. Please follow standard Ruby development practices for contributions.