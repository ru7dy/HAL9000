module SlackBot
  module Commands
    class Faceify < SlackRubyBot::Bot
      match /^faceify me about (?<term>.*)$/ do |client, data, match|
        # return an image url from Bing
        url = BingIntegration::Client.image_search(
            {
              :query => "#{match[:term]}",
            }
          )
        #
        resp = FaceplusIntegration::Client.query({:image_url => url})
        client.say(channel: data.channel, text: resp)
      end
    end
  end
end
