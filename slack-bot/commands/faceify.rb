module SlackBot
  module Commands
    class Faceify < SlackRubyBot::Bot
      match /^faceify me about (?<sth2eat>\w*)$/ do |client, data, match|
        #resp = FacePlusIntegration::Client.query("San Francisco", {:term => "#{match[:sth2eat]}"})
resp = FaceplusIntegration::Client.query("San Francisco", {:term => "#{match[:sth2eat]}"})
        client.say(channel: data.channel, text: resp)
      end
    end
  end
end
