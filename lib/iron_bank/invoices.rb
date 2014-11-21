# encoding: utf-8

module IronBank
  class Invoices < IronBank::Base
    def initialize(api)
      @api = api
    end

    def all
      response = self.class.get(
          '/sales/invoices',
          headers: @api.authorization_headers
      )

      if response.code == 200
        raw_invoices = response.parsed_response
        invoices = []
        raw_invoices.each{ |i|
          invoices << parse_invoice(i)

        }
        return invoices
      else
        raise RequestError.new(response)
      end
    end

    def parse_invoice(raw_invoice)
      Invoice.new(@api, nil, raw_invoice)
    end
  end
end