# encoding: utf-8

module IronBank
  class CreditNotes < IronBank::Base
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
      url = '/sales/creditnotes/v4'
      querystring = ''
      querystring += "&fromDate=#{@from}" unless @from.nil?
      querystring += "&toDate=#{@to}" unless @to.nil?
      querystring += "&einvoiceStatus=#{@electronic_status}" unless @electronic_status.nil?
      response = self.class.get(
          "#{url}?#{querystring}",
          headers: @api.authorization_headers
      )
      build_credit_notes(response)
    end

    def all_from_to(from, to)
      from(from).to(to).retrieve
    end

    def all
      response = self.class.get(
          '/sales/creditnotes/v4',
          headers: @api.authorization_headers
      )
      build_credit_notes(response)
    end

    def build_credit_notes(response)
      if response.code == 200
        raw_credit_notes = response.parsed_response
        credit_notes = []
        raw_credit_notes.each { |i|
          credit_notes << parse_credit_note(i)

        }
        return credit_notes
      else
        raise RequestError.new(response)
      end
    end

    def parse_credit_note(raw_credit_note)
      CreditNote.new(@api, nil, raw_credit_note)
    end
  end
end