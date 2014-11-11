# encoding: utf-8

module IronBank

  class Invoice < IronBank::Base

    def initialize(api, invoice_id = nil)
      @api        = api
      @attributes = {}

      if invoice_id
        response = self.class.get(
          "/sales/invoices/#{invoice_id}",
          headers: @api.authorization_headers
        )

        if response.code == 200
          @attributes = response.parsed_response
        else
          raise RequestError.new(response)
        end
      end
    end

    def deliver(options = {})
      raise BaseError.new("invoice.id missing") unless self.id

      response = self.class.post(
        "/sales/invoices/#{self.id}/email",
        body: options.camelize_keys!.to_json,
        headers: @api.authorization_headers
      )

      if response.code != 200
        raise RequestError.new(response)
      end

      self
    end

    def method_missing(m, *args, &block)
      if @attributes.has_key?(m.to_s)
        @attributes[m.to_s]
      else
        super
      end
    end

  end

end