#https://github.com/andrewrjones/ruby-duck-duck-go
require 'duck-duck-go'

module DuckduckgoIntegration
  class Client
    def self.query(params)
      ddg = DuckDuckGo.new
      zci = ddg.zeroclickinfo(params[:term])
      client.say(channel: data.channel, text: zci.to_s)
    end
  end
end
