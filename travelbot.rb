require 'slack-ruby-bot'
require 'pp'
require 'uri'

class TravelBot < SlackRubyBot::Bot
  def self.flight_search
    url = "http://terminal2.expedia.com/x/mflights/search?departureAirport=LAX&arrivalAirport=ORD&departureDate=2016-04-22&childTravelerAge=2&apikey=#{ENV['EXPEDIA_KEY']}"
    response = HTTParty.get(url)
    offer_prices = []
    legs = response["legs"]
    offers = response["offers"]
    offer_top_ten = []
    legs_ids = []
    # offers_ids = []
    # top ten legIds  for i in 0...10
    # offers.each do |offer|
    #   offers_ids << offers[i]["legIds"]
      # offer_top_ten << offers[i]["totalFarePrice"]["formattedPrice"]
    flights = []

    legs.each do |leg|
      offers.each do |offer|
        if offer['legIds'].first == leg["legId"]
           flights << {price: offer["totalFarePrice"]["formattedPrice"], link: offer["detailsUrl"]}

        end
      end
    end
    # offers.each do |offer|

    # end
    return "<a href=#{flights.first[:link]}Book Now>"
  end
  def self.shorten(long_url)
    enc = CGI::escape(long_url)
    bitlyendpoint = "https://api-ssl.bitly.com/v3/shorten?access_token=6836af0100785631ed7e8338c6adbe9729fed013&longUrl=#{enc}"
    p bitlyendpoint
    response = HTTParty.get(bitlyendpoint)
    p response
    #response["data"]["url"]
  end
  # formatted total fare: response['offers'].first["totalFarePrice"]["formattedPrice"]

  # {formattedPrice:
  #  }

  # offers = response["offers"]
  # offers.each do |prices|



  command 'ping' do |client, data, match|
    response = flight_search
    p shorten("http://google.com/")
    client.say(text: response, channel: data.channel)
  end

  command 'test' do |client, data, match|
    client.say(text: 'connected', channel: data.channel)
  end
end

TravelBot.run


# http://terminal2.expedia.com/x/mflights/search?departureAirport=LAX&arrivalAirport=ORD&departureDate=2016-04-22&childTravelerAge=2&apikey=