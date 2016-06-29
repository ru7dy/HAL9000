require 'sinatra/base'

module SlackBot
  class Web < Sinatra::Base
    get '/' do
      'Math is good for you.'
    end
  end
end
