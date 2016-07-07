require 'json'


module SlackBot
  module Commands
    class Airface < SlackRubyBot::Bot
      GOOD_MATCH = 0.5
      OKAY_MATCH = 2.0

      def self.process(url1, url2, client, data, match)
        resp = AirfaceIntegration::Client.query(
            {
              :url1 => url1,
              :url2 => url2
            }
          )

        title = "WARNING IMAGES DO NOT MATCH!"
        text = "Strong :fish:iness detected! Please investigate further!"
        color = "#ff0000"
        image_url = "http://images.clipartpanda.com/criminal-clipart-Criminal8.jpg"


        if resp.to_i < GOOD_MATCH && resp.to_i >= 0
          title = "Images Match!"
          text = ":thumbsup: No :fish:iness detected! Nothing to see here"
          color = "#00ff00"
          image_url = "http://thingiverse-production-new.s3.amazonaws.com/renders/2d/ad/85/5c/de/LGTM_1_preview_featured.jpg"
        elsif resp.to_i < OKAY_MATCH && resp.to_i >= 0
          title = "Not a Strong Match between the Images!"
          text = "Some :fish:iness detected! Further investigation may be needed"
          color = "#ffff00"
        end

        p1 = JSON.parse(BingIntegration::Client.face_analysis(:query => url1))
        p2 = JSON.parse(BingIntegration::Client.face_analysis(:query => url2))

        if p1.present? && p2.present?
          p1 = p1[0]['faceAttributes']
          p2 = p2[0]['faceAttributes']

          p1_age = p1['age'].to_i
          p1_gender = p1['gender']

          p2_age = p2['age'].to_i
          p2_gender = p2['gender']

          p1_emoticon = Helper.get_emoticon(p1_age, p1_gender)
          p2_emoticon = Helper.get_emoticon(p2_age, p2_gender)

          client.web_client.chat_postMessage(
            channel: data.channel,
            as_user: true,
            attachments: [
              fallback: "First Profile:",
              title: "First profile is: #{p1_emoticon}",
              text: "A #{p1_gender} about #{p1_age} years old",
              image_url: url1,
            ]
          )

          client.web_client.chat_postMessage(
            channel: data.channel,
            as_user: true,
            attachments: [
              fallback: "Second profile",
              title: "Second profile is: #{p2_emoticon}",
              text: "A #{p2_gender} about #{p2_age} years old",
              image_url: url2,
            ]
          )

          client.web_client.chat_postMessage(
            channel: data.channel,
            as_user: true,
            attachments: [
              fallback: title,
              title: title,
              text: text,
              color: color,
              image_url: image_url,
            ]
          )
        else
          client.web_client.chat_postMessage(
            channel: data.channel,
            as_user: true,
            attachments: [
              fallback: "Some of the pictures were not human",
              title: "Some of the pictures were not human",
              text: text,
              color: color,
              image_url: image_url,
            ]
          )
        end
      end

      match /^airface :(?<query1>.*): :(?<query2>.*):$/ do |client, data, match|
        url1 = BingIntegration::Client.image_search(
            {
              :query => "#{match[:query1]}"
            }
          )

        url2 = BingIntegration::Client.image_search(
            {
              :query => "#{match[:query2]}"
            }
          )

        process(url1, url2, client, data, match)
      end

      match /^airface (?<url1>.*) (?<url2>.*)$/ do |client, data, match|
        resp = AirfaceIntegration::Client.query(
            {
              :url1 => "#{match[:url1]}",
              :url2 => "#{match[:url2]}",
            }
          )
        client.say(channel: data.channel, text: resp)
      end

      match /^airface url:(?<url>.*)$/ do |client, data, match|
        url1 = match[:url].split(",")[0]
        url2 = match[:url].split(",")[1]

        url1 = url1[1..(url1.length)]
        # da fuq?????
        url2 = url2[0..(url2.length-2)]

        process(url1, url2, client, data, match)
      end
    end
  end
end

