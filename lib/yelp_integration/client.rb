#https://github.com/Yelp/yelp-ruby
require 'yelp'

module YelpIntegration
  class Client
    def self.query(city, params)
      client = Yelp::Client.new({ consumer_key: 'KH7e0YJNALkAqjch2X3r-g',
                                  consumer_secret: 'J6Lu5DBor5HQHT4VSipFqm6LRVc',
                                  token: 'nzRtw0qgDXqW6D6Nc8gDZOmMqpBaPCtX',
                                  token_secret: 'Ti0kfu0begnJglPCaK-CpUvov8s'
                                })
      city ||= 'San Francisco'
      params['term'] ||= 'food'
      params['limit'] ||= 5
      response = client.search(city, params)
      response.businesses.join(',')
    end
  end
end


