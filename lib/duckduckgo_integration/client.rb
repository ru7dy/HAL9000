#https://github.com/andrewrjones/ruby-duck-duck-go
require "duck_duck_go"

module DuckduckgoIntegration
  class Client

    def self.query(params)
      ddg = DuckDuckGo.new
      zci = ddg.zeroclickinfo(params[:term])
      ret = zci.related_topics
      ret = ddg.zeroclickinfo("no one").related_topics if ret == {}
      package(ret["_"][0])
    end

    def self.package(topic)
      [topic.text, topic.icon.url]
    end
  end
end
