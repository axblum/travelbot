require 'slack-ruby-bot'
require 'pp'

class TravelBot < SlackRubyBot::Bot
  def self.flight_search
    url = "http://terminal2.expedia.com/x/mflights/search?departureAirport=LAX&arrivalAirport=ORD&departureDate=2016-04-22&childTravelerAge=2&apikey=#{ENV['EXPEDIA_KEY']}"
    response = HTTParty.get(url)
    offer_prices = []
    legs = response["legs"]
    offers = response["offers"]
    offer_top_ten = []
    legs_ids = []
    offers_ids = []
    # top ten legIds for cheapest flights
    for i in 0...10
      offers_ids << offers[i]["legIds"]
      # offer_top_ten << offers[i]["totalFarePrice"]["formattedPrice"]
    end
    flight = []
    legs.each do |leg|
      if offers_ids.first == leg["legId"]
        flight = leg["legId"]
      end
    end
    # offers.each do |offer|
    #   offer_prices << offer["totalFarePrice"]["formattedPrice"]
    # end
    return flight
  end

  # formatted total fare: response['offers'].first["totalFarePrice"]["formattedPrice"]

  # {formattedPrice:
  #  }

  # offers = response["offers"]
  # offers.each do |prices|



  command 'ping' do |client, data, match|
    response = flight_search
    p " -- " * 20
    pp response
    client.say(text: response, channel: data.channel)
  end

  command 'test' do |client, data, match|
    client.say(text: 'connected', channel: data.channel)
  end
end

TravelBot.run


# http://terminal2.expedia.com/x/mflights/search?departureAirport=LAX&arrivalAirport=ORD&departureDate=2016-04-22&childTravelerAge=2&apikey=