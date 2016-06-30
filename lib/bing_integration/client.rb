require 'net/http'
require 'json'

module BingIntegration
  class Client
    # PWNED AGAIN
    API_KEY = '8707eaa896104611988b170359d7ae39'

    # PLEASE DONT CHANGE
    IMAGE_ENDPOINT = 'https://api.cognitive.microsoft.com/bing/v5.0/images/search'

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
  end
end


