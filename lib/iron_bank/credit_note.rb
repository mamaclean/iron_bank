# encoding: utf-8

module IronBank

  class CreditNote < IronBank::Base

    def initialize(api, credit_note_id = nil, attributes = nil)
      @api        = api
      @attributes = {}

      if attributes
        @attributes = attributes
      end

      if credit_note_id
        response = self.class.get(
          "/sales/creditnotes/#{credit_note_id}/v4",
          headers: @api.authorization_headers
        )

        if response.code == 200
          @attributes = response.parsed_response
        else
          raise RequestError.new(response)
        end
      end
    end

    def save
      raise BaseError.new("creditnote.id missing") unless self.id
      response = self.class.put(
          "/sales/creditnotes/#{self.id}/v4",
          headers: @api.authorization_headers.merge({"Content-Type" => "application/json"}),
          body: @attributes.to_json
      )
      if response.code != 200
        raise RequestError.new(response)
      end
    end

    def deliver(options = {})
      raise BaseError.new("creditnote.id missing") unless self.id

      response = self.class.post(
        "/sales/creditnotes/#{self.id}/email/v4",
        body: options.camelize_keys!.to_json,
        headers: @api.authorization_headers.merge({"Content-Type" => "application/json"})
      )

      if response.code != 200
        raise RequestError.new(response)
      end

      self
    end

    def pdf
      download_invoice("/sales/creditnotes/#{self.id}/pdf/v4")
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