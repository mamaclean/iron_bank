module IronBank

  class PaymentTerms < IronBank::Base

    def initialize(api)
      @api = api
    end

    def all
      response = self.class.get('/sales/paymentterms', headers: @api.authorization_headers)
      response.parsed_response
    end

  end

end
