# encoding: utf-8

module IronBank
  class Invoices < IronBank::Base
    def initialize(api)
      @api = api
    end

    def from(from)
      @from = from
      self
    end

    def to(to)
      @to = to
      self
    end

    def electronic_status(electronic_status)
      @electronic_status = electronic_status
      self
    end

    def retrieve
      url = '/sales/invoices/v4'
      querystring = ''
      querystring += "&fromDate=#{@from}" unless @from.nil?
      querystring += "&toDate=#{@to}" unless @to.nil?
      querystring += "&einvoiceStatus=#{@electronic_status}" unless @electronic_status.nil?
      response = self.class.get(
          "#{url}?#{querystring}",
          headers: @api.authorization_headers
      )
      build_invoices(response)
    end

    def all_from_to(from, to)
      from(from).to(to).retrieve
    end

    def all
      response = self.class.get(
          '/sales/invoices/v4',
          headers: @api.authorization_headers
      )
      build_invoices(response)
    end

    def build_invoices(response)
      if response.code == 200
        raw_invoices = response.parsed_response
        invoices = []
        raw_invoices.each { |i|
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