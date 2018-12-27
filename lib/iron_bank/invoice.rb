# encoding: utf-8

module IronBank

  class Invoice < IronBank::Base

    def initialize(api, invoice_id = nil, attributes = nil)
      @api        = api
      @attributes = {}

      if attributes
        @attributes = attributes
      end

      if invoice_id
        response = self.class.get(
          "/sales/invoices/#{invoice_id}/v3",
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
        "/sales/invoices/#{self.id}/email/v2",
        body: options.camelize_keys!.to_json,
        headers: @api.authorization_headers
      )

      if response.code != 200
        raise RequestError.new(response)
      end

      self
    end

    def send_electronic_invoice(options = {})
      raise BaseError.new("invoice.id missing") unless self.id

      response = self.class.post(
          "/sales/invoices/#{self.id}/xml/send/v1",
          body: options.camelize_keys!.to_json,
          headers: @api.authorization_headers
      )

      if response.code == 200
        sdi_receipt = response.parsed_response
      else
        raise RequestError.new(response)
      end
      sdi_receipt
    end

    def pdf
      download_invoice("/sales/invoices/#{self.id}/pdf/v1")
    end

    def einvoice_xml
      download_invoice("/sales/invoices/#{self.id}/xml/v1")
    end

    def einvoice_pdf
      download_invoice("/sales/invoices/#{self.id}/xml/pdf/v1")
    end

    def download_invoice(path)
      raise BaseError.new("invoice.id missing") unless self.id

      response = self.class.get(
          path,
          headers: @api.authorization_headers
      )
      if response.code == 200
        downloaded_content = response.parsed_response
      else
        raise RequestError.new(response)
      end
      downloaded_content
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