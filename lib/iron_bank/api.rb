module IronBank
  class Api < IronBank::Base
    attr_reader :token

    def initialize(options = {})
      @token = options[:access_token]
    end

    def authorization_headers
      {"x-token" => @token}
    end

    def payment_terms
      PaymentTerms.new(self).all
    end

    def draft_invoice(id = nil)
      DraftInvoice.new(self, id)
    end

    def invoice(id = nil)
      Invoice.new(self, id)
    end

    protected

      def authorization_uri
        "https://app.debitoor.com/login/oauth2/authorize"
      end

      def token_uri
        "https://app.debitoor.com/login/oauth2/access_token"
      end

      def site_uri
        "https://app.debitoor.com"
      end

      def callback_uri
        "https://www.bloomydays.com/success"
      end

  end
end