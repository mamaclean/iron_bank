module IronBank

  class Base
    include HTTParty

    base_uri "https://api.debitoor.com/api/v1.0"
  end

  class RequestError < StandardError; end
  class BaseError < StandardError; end

end