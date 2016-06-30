module SlackBot
  module Commands
    class Yelpify < SlackRubyBot::Bot
      match /^yelpify me about (?<sth2eat>\w*)$/ do |client, data, match|
        resp = YelpIntegration::Client.query("San Francisco", {:term => "#{match[:sth2eat]}"})
        resp.each do |url|
          client.say(channel: data.channel, text: url)
        end
      end
    end
  end
end