module SlackBot
  module Commands
    class Weather < SlackRubyBot::Bot
      GOOD_THRESHOLD = 50

      randnum = rand(100)
      color = randnum > GOOD_THRESHOLD ? "#00ff00" : "#ff0000"
      text = randnum > GOOD_THRESHOLD ? "good" : "bad"

      match /^Weather in (?<location>\w*)\?$/ do |client, data, match|
        client.web_client.chat_postMessage(
          channel: data.channel,
          as_user: true,
          attachments: [
            title: "Hackabot sez",
            text: "The weather in #{match[:location]} is #{text}",
            image_url: BingIntegration::Client.image_search(
              {
                :query => "#{match[:location]}",
              }
            ),
            color: color,
          ]
        )
      end
    end
  end
end
