require 'net/http'
require 'json'

module BingIntegration
  class Client
    # PWNED AGAIN
    API_KEY = '8707eaa896104611988b170359d7ae39'
    FACE_API_KEY = '4be93526548e4125b8726b12f5b2d9e8'

    # PLEASE DONT CHANGE
    IMAGE_ENDPOINT = 'https://api.cognitive.microsoft.com/bing/v5.0/images/search'
    FACE_ENDPOINT = 'https://api.projectoxford.ai/face/v1.0/detect'

    EXAMPLE_URL = 'http://vis-www.cs.umass.edu/lfw/images/Angela_Bassett/Angela_Bassett_0001.jpg'

    def self.image_search(params)
      uri = URI(IMAGE_ENDPOINT)
      uri.query = URI.encode_www_form(
        {
          'q' => params[:query].to_s,
          'count' => '1',
          'offset' => '0',
          'mkt' => 'en-us',
          'safesearch' => 'Moderate',
        }
      )

      request = Net::HTTP::Get.new(uri.request_uri)
      request['Ocp-Apim-Subscription-Key'] = API_KEY

      response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(request)
      end

      # TODO: HOW TO FIGURE OUT JSON????? ALL THE WEB READERS DIDNT WORK!!!
      # THIS TOOK ME WAY TOO LONG TO FIGURE OUT :((((( UGHHHH
      # Generic: JSON.parse(response.body)['images']['value'][0]['contentUrl']

      JSON.parse(response.body)['value'][0]['contentUrl']
    end

    def self.face_analysis(params)
      uri = URI(FACE_ENDPOINT)
      uri.query = URI.encode_www_form(
        {
          'returnFaceId' => 'true',
          'returnFaceLandmarks' => 'false',
          'returnFaceAttributes' => 'age,gender'
        }
      )

      request = Net::HTTP::Post.new(uri.request_uri)

      request['Content-Type'] = 'application/json'

      # Request headers
      request['Ocp-Apim-Subscription-Key'] = FACE_API_KEY

      bing_url = BingIntegration::Client.image_search(params).to_s
      # Request body
      request.body = JSON.generate(
        {
          "url" => params[:query],
        }
      )
      #request.body = JSON.generate( {"url" => EXAMPLE_URL})

      response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(request)
      end

      response.body
    end
  end
end


