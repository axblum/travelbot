require 'slack-ruby-bot'


class TravelBot < SlackRubyBot::Bot
  # Instentiate api object
  api = Expedia::Api.new

  # Method to search for a hotel. see http://developer.ean.com/docs/hotel-list/
  response = api.get_list({:propertyName => 'Hotel Moa', :destinationString => 'berlin'})

  # execute this method to know if there is any exception
  response.exception? # false if success
  
  command 'ping' do |client, data, match|
    client.say(text: 'travel', channel: data.channel)
  end
end

TravelBot.run
