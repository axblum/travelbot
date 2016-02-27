require 'slack-ruby-bot'

class TravelBot < SlackRubyBot::Bot
  command 'ping' do |client, data, match|
    client.say(text: 'travel', channel: data.channel)
  end
end

TravelBot.run
