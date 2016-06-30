require 'net/http'

module FaceplusIntegration
  class Client
    # PWNED LOL
    API_KEY = '1e9279d0ea611cec36c4b2605b9577eb'

    # ROTATE THIS LOL
    API_SECRET = 'xFbmYlsvyDwlHwcWkuE0NWn1aQoZPqrm'

    # PLEASE DONT CHANGE
    ENDPOINT = 'http://apius.faceplusplus.com/v2/detection/detect'

    EXAMPLE_URL = 'http://vis-www.cs.umass.edu/lfw/images/Angela_Bassett/Angela_Bassett_0001.jpg'

    def self.query(city, params)
      url = "#{ENDPOINT}?api_key=#{API_KEY}&api_secret=#{API_SECRET}&url=#{EXAMPLE_URL}"
      url = URI.parse(url)
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) { |http|
        http.request(req)
      }
      res.body
    end
  end
end


