require 'net/http'
require 'json'

module AirfaceIntegration
  class Client
    # Hi Jerry!!
    ENDPOINT = 'http://i-fa188261.inst.aws.airbnb.com/match_from_urls'

    EXAMPLE_URL = 'http://vis-www.cs.umass.edu/lfw/images/Angela_Bassett/Angela_Bassett_0001.jpg'

    def self.query(params)
      first_url = params[:url1]
      second_url = params[:url2]
      url = "#{ENDPOINT}?url1=#{first_url}&url2=#{second_url}"

      url = URI.parse(url)
      resp = Net::HTTP.get(url)

      JSON.parse(resp)['dist']
    end
  end
end


