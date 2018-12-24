module IronBank

  class Base
    include HTTParty

    base_uri "https://api.debitoor.com/api"
  end

  class RequestError < StandardError; end
  class BaseError < StandardError; end

end