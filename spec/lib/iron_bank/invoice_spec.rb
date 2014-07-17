# encoding: utf-8

require_relative '../../spec_helper'

describe IronBank::Invoice do

  describe "send existing invoice" do
    before do
      VCR.insert_cassette 'invoices', record: :new_episodes, match_requests_on: [:method, :uri, :body]
      @debitoor = IronBank::Api.new(access_token: ENV["DEBITOOR_ACCESS_TOKEN"])
    end
    after { VCR.eject_cassette }

    it "must send an invoice via mail" do
      invoice = @debitoor.invoice("53c7d396382923ad09390622").deliver(
        recipient: "kontakt@enricogenauck.de",
        subject: "Your new invoice $[NUMBER]",
        message: "Hi there\nplease pay.",
        attachment_name: "Rechnung $[NUMBER] - BLOOMY DAYS GmbH.pdf",
        attach_pdf: true
      )
      invoice.wont_be_nil
    end
  end
end
