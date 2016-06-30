module SlackBot
  module Commands
    class Quack < SlackRubyBot::Bot
      match /^quack, (?<term>.*)$/ do |client, data, match|
        result = DuckduckgoIntegration::Client.query({ :term => "#{match[:term]}" })
        result.each do |item|
          client.say(channel: data.channel, text: item)
        end
      end
    end
  end
end