module SlackBot
  module Commands
    class Airface < SlackRubyBot::Bot
      match /^airface (?<url1>.*) (?<url2>.*)$/ do |client, data, match|
        resp = AirfaceIntegration::Client.query(
            {
              :url1 => "#{match[:url1]}",
              :url2 => "#{match[:url2]}",
            }
          )
        client.say(channel: data.channel, text: resp)
      end
    end
  end
end

