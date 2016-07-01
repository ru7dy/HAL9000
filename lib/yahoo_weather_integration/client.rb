require 'net/http'

module YahooWeatherIntegration
  class Client
    # Never Used
    CLIENT_ID = 'dj0yJmk9aWtXV3ppVExVTGFMJmQ9WVdrOU9VRXlhVnAzTkRnbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD1kNw--'
    CLIENT_SECRET = '9d46b4a57ee40b93e9b4b0afdf3a105a4cf69250'

    # PLEASE DONT CHANGE
    ENDPOINT = 'https://query.yahooapis.com/v1/public/yql'

    EXAMPLE_URL = 'http://vis-www.cs.umass.edu/lfw/images/Angela_Bassett/Angela_Bassett_0001.jpg'

    def self.query(params)
      yql =
        "select item.condition.text from weather.forecast where woeid in (select woeid from geo.places(1) where text=\"#{params[:location]}\")"
      url = "#{ENDPOINT}" + "?q=" + "#{yql}" + "&format=json"
      uri = URI.parse(url)
      req = Net::HTTP::Get.new(uri.to_s)
      res = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') { |http|
        http.request(req)
      }
      JSON.parse(res.body)["query"]["results"]["channel"]["item"]["condition"]["text"]
    end
  end
end