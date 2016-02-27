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
  def self.attachment
    # @a = [ { author_name: "Bobby Tables", fallback: "Buy Your Ticket", text: "Booking", pretext: "Booking", title: "Ticket", id: 1, title_link: "http:\/\/www.expedia.com\/pubspec\/scripts\/eap.asp?GOTO=UDP&piid=v5-822766cf26604ccb97a0d94985a94a4b-24-1&price=366.20&currencyCode=USD&departTLA=L1:LAX&arrivalTLA=L1:ORD&departDate=L1:2016-04-22&nAdults=1&nSeniors=0&infantInLap=N&nChildren=1&class=coach&sort=Price&tripType=OneWay&productType=air&eapid=0-1&serviceVersion=V5&langid=1033", author_link: "http:\/\/flickr.com\/bobby\/", color: "36a64f", fields: [ { title: "Priority", value: "High", short: false } ] } ].to_json
    # json_obj = {ok: true, channel: "C0PACRTSA", ts: "1456601992.000099", message: { text: "test", username: "@themcny", attachments: [ { author_name: "Bobby Tables", fallback: "Buy Your Ticket", text: "Booking", pretext: "Booking", title: "Ticket", id: 1, title_link: "http:\/\/www.expedia.com\/pubspec\/scripts\/eap.asp?GOTO=UDP&piid=v5-822766cf26604ccb97a0d94985a94a4b-24-1&price=366.20&currencyCode=USD&departTLA=L1:LAX&arrivalTLA=L1:ORD&departDate=L1:2016-04-22&nAdults=1&nSeniors=0&infantInLap=N&nChildren=1&class=coach&sort=Price&tripType=OneWay&productType=air&eapid=0-1&serviceVersion=V5&langid=1033", author_link: "http:\/\/flickr.com\/bobby\/", color: "36a64f", fields: [ { title: "Priority", value: "High", short: false } ] } ], type: "message", subtype: "bot_message", ts: "1456601992.000099" } }
    #  HTTParty.post("https://slack.com/api/chat.postMessage?token=#{ENV['SLACK_API_TOKEN']}&channel=%23travelbot1_0&text=text&attachments=#{@a}&pretty=1")

    url = "https://slack.com/api/chat.postMessage?token=xoxp-15961436708-15967473650-23393678706-7459ae03b3&amp;channel=%23travelbot1_0&amp;text=Book%20Your%20Ticket%20Now&amp;attachments=%20%20%5B%20%20%20%20%20%7B%20%20%20%20%20%20%20%20%20%20%22fallback%22%3A%20%22Buy%20Your%20Ticket%22%2C%20%20%20%20%20%20%20%20%20%22text%22%3A%20%22Booking%22%2C%20%20%20%20%20%20%20%20%20%22pretext%22%3A%20%22Booking%22%2C%20%20%20%20%20%20%20%20%20%22title%22%3A%20%22Ticket%22%2C%20%20%20%20%20%20%20%20%20%22id%22%3A%201%2C%20%20%20%20%20%20%20%20%20%22title_link%22%3A%20%22http%3A%5C%2F%5C%2Fwww.expedia.com%5C%2Fpubspec%5C%2Fscripts%5C%2Feap.asp%3FGOTO%3DUDP%26piid%3Dv5-822766cf26604ccb97a0d94985a94a4b-24-1%26price%3D366.20%26currencyCode%3DUSD%26departTLA%3DL1%3ALAX%26arrivalTLA%3DL1%3AORD%26departDate%3DL1%3A2016-04-22%26nAdults%3D1%26nSeniors%3D0%26infantInLap%3DN%26nChildren%3D1%26class%3Dcoach%26sort%3DPrice%26tripType%3DOneWay%26productType%3Dair%26eapid%3D0-1%26serviceVersion%3DV5%26langid%3D1033%22%2C%20%20%20%20%20%20%20%20%20%22author_link%22%3A%20%22http%3A%5C%2F%5C%2Fflickr.com%5C%2Fbobby%5C%2F%22%2C%20%20%20%20%20%20%20%20%20%22color%22%3A%20%2236a64f%22%2C%20%20%20%20%20%20%20%20%20%22fields%22%3A%20%5B%20%20%20%20%20%20%20%20%20%20%20%20%20%7B%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22title%22%3A%20%22Buy%20Your%20Ticket%22%2C%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22value%22%3A%20%22Ticket%22%2C%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22short%22%3A%20false%20%20%20%20%20%20%20%20%20%20%20%20%20%7D%20%20%20%20%20%20%20%20%20%5D%20%20%20%20%20%7D%20%5D&amp;pretty=1"
    HTTParty.post("https://slack.com/api/chat.postMessage?token=xoxp-15961436708-15967473650-23393678706-7459ae03b3&channel=%23travelbot1_0&text=Book%20Your%20Ticket%20Now&pretty=1")
    p 'posted'
  end


  command 'ping' do |client, data, match|
    response = flight_search
    p shorten("http://google.com/")
    client.say(text: response, channel: data.channel)
  end

  command 'test' do |client, data, match|
    client.say(text: 'connected', channel: data.channel)
  end

  command 'attach' do |client, data, match|
    p 'attaching'
    attachment
  end
end

TravelBot.run


# http://terminal2.expedia.com/x/mflights/search?departureAirport=LAX&arrivalAirport=ORD&departureDate=2016-04-22&childTravelerAge=2&apikey=


# [
#   {

#       "fallback": "Buy Your Ticket",
#       "text": "Booking",
#       "pretext": "Booking",
#       "title": "Ticket",
#       "id": 1,
#       "title_link": "http:\/\/www.expedia.com\/pubspec\/scripts\/eap.asp?GOTO=UDP&piid=v5-822766cf26604ccb97a0d94985a94a4b-24-1&price=366.20&currencyCode=USD&departTLA=L1:LAX&arrivalTLA=L1:ORD&departDate=L1:2016-04-22&nAdults=1&nSeniors=0&infantInLap=N&nChildren=1&class=coach&sort=Price&tripType=OneWay&productType=air&eapid=0-1&serviceVersion=V5&langid=1033",
#       "author_link": "http:\/\/flickr.com\/bobby\/",
#       "color": "36a64f",
#       "fields": [
#           {
#               "title": "Buy Your Ticket",
#               "value": "Ticket",
#               "short": false
#           }
#       ]
#   }
# ]

# https://slack.com/api/chat.postMessage?
# token=xoxp-15961436708-15967473650-23393678706-7459ae03b3&amp;
# channel=%23travelbot1_0&amp;
# text=Book%20Your%20Ticket%20Now&amp;
# attachments=%20%20%5B%20%20%20%20%20%7B%20%20%20%20%20%20%20%20%20%20%22
#   fallback%22%3A%20%22Buy%20Your%20Ticket%22%2C%20%20%20%20%20%20%20%20%20%22
#   text%22%3A%20%22Booking%22%2C%20%20%20%20%20%20%20%20%20%22
#   pretext%22%3A%20%22Booking%22%2C%20%20%20%20%20%20%20%20%20%22
#   title%22%3A%20%22Ticket%22%2C%20%20%20%20%20%20%20%20%20%22
#   id%22%3A%201%2C%20%20%20%20%20%20%20%20%20%22
#   title_link%22%3A%20%22http%3A%5C%2F%5C%2Fwww.expedia.com%5C%2Fpubspec%5C%2Fscripts%5C%2Feap.asp%3FGOTO%3DUDP%26piid%3Dv5-822766cf26604ccb97a0d94985a94a4b-24-1%26price%3D366.20%26currencyCode%3DUSD%26departTLA%3DL1%3ALAX%26arrivalTLA%3DL1%3AORD%26departDate%3DL1%3A2016-04-22%26nAdults%3D1%26nSeniors%3D0%26infantInLap%3DN%26nChildren%3D1%26class%3Dcoach%26sort%3DPrice%26tripType%3DOneWay%26productType%3Dair%26eapid%3D0-1%26serviceVersion%3DV5%26langid%3D1033%22%2C%20%20%20%20%20%20%20%20%20%22
#   author_link%22%3A%20%22http%3A%5C%2F%5C%2Fflickr.com%5C%2Fbobby%5C%2F%22%2C%20%20%20%20%20%20%20%20%20%22color%22%3A%20%2236a64f%22%2C%20%20%20%20%20%20%20%20%20%22fields%22%3A%20%5B%20%20%20%20%20%20%20%20%20%20%20%20%20%7B%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22
#   title%22%3A%20%22Buy%20Your%20Ticket%22%2C%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22
#   value%22%3A%20%22Ticket%22%2C%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%22short%22%3A%20false%20%20%20%20%20%20%20%20%20%20%20%20%20%7D%20%20%20%20%20%20%20%20%20%5D%20%20%20%20%20%7D%20%5D&amp;
# pretty=1
