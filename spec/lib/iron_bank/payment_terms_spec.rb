require_relative '../../spec_helper'

describe IronBank::PaymentTerms do

  before do
    VCR.insert_cassette 'payment_terms'
    @debitoor = IronBank::Api.new(access_token: ENV["DEBITOOR_ACCESS_TOKEN"])
  end

  after { VCR.eject_cassette }

  it "must get list of payment terms" do
    @debitoor.payment_terms.wont_be_empty
  end

end
