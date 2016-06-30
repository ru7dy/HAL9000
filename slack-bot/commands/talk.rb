module SlackBot
  module Commands
    class Talk < SlackRubyBot::Commands::Base
      command 'hi' do |client, data, _match|
        client.say(channel: data.channel, text: 'hello')
      end

      command 'Who is the King?' do |client, data, _match|
        client.say(channel: data.channel, text: "Long live the king, <@#{data.user}>", gif: 'king')
      end
    end
  end
end
