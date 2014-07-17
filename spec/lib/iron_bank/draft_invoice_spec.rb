# encoding: utf-8

require_relative '../../spec_helper'

describe IronBank::DraftInvoice do

  describe "default attributes" do

    it "must include httparty methods" do
      IronBank::DraftInvoice.must_include HTTParty
    end

    it "must have the base url set to the Dribble API endpoint" do
      IronBank::DraftInvoice.base_uri.must_equal 'https://api.debitoor.com/api/v1.0'
    end

  end

  describe "create new draft invoice" do
    before do
      VCR.insert_cassette 'draft_invoices', record: :new_episodes, match_requests_on: [:method, :uri, :body]
      @debitoor = IronBank::Api.new(access_token: ENV["DEBITOOR_ACCESS_TOKEN"])
    end
    after { VCR.eject_cassette }

    it "must create a new draft invoice" do
      draft_invoice = @debitoor.draft_invoice.create(
        payment_terms_id: 1,
        customer_name:      "Guybrush Threepwood",
        customer_address:   "Little island on the left 3",
        customer_country:   "DE",
        notes:              "First note",
        additional_notes:   "Second note",
        price_display_type: "gross",
        lines: [
          {
            product_name: "Stan's ship",
            unit_gross_price: 5000,
            quantity: 1,
            tax_rate: 19,
            tax_enabled: true
          }
        ]
      )
      draft_invoice.id.must_equal "53c7d396382923ad09390622"
    end

    it "must book a draft invoice" do
      invoice = @debitoor.draft_invoice("53c7d396382923ad09390622")
      invoice.book

      invoice.paid.must_equal false
    end

  end
end
