require 'slack-ruby-bot'
require 'pp'

class TravelBot < SlackRubyBot::Bot
  def self.flight_search
    url = "http://terminal2.expedia.com/x/mflights/search?departureAirport=LAX&arrivalAirport=ORD&departureDate=2016-04-22&childTravelerAge=2&apikey=#{ENV['EXPEDIA_KEY']}"
    response = HTTParty.get(url)
    response['offers'].first["baseFare"]
  end

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