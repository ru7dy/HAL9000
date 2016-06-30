module SlackBot
  module Commands
    class Bingify < SlackRubyBot::Bot
      match /^bingify (?<query>\w*)$/ do |client, data, match|
        resp = BingIntegration::Client.image_search(
            {
              :query => "#{match[:query]}",
            }
          )
        client.say(channel: data.channel, text: resp)
      end

      match /^bingalize (?<query>\w*)$/ do |client, data, match|
        resp = BingIntegration::Client.face_analysis(
            {
              :query => "#{match[:query]}",
            }
          )
        client.say(channel: data.channel, text: resp)
      end
    end
  end
end

