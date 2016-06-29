module SlackBot
  module Commands
    class Calculate < SlackRubyBot::Commands::Base
      command 'calculate' do |client, data, _match|
        client.say(channel: data.channel, text: '4')

      end

      command 'hi' do |client, data, _match|
        client.say(channel: data.channel, text: 'hello')
      end

      command 'Who is the King?' do |client, data, _match|
        resp = YelpIntegration::Client.query("San Francisco", {:term => 'food'})

        client.say(channel: data.channel, text: resp.to_s)
      end
    end
  end
end
