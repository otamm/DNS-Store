require 'rails_helper'

RSpec.describe DnsRecord, type: :model do
  describe "validates attributes" do
  	before(:all) do
  		@invalid_record = build(:dns_record)
  		@invalid_record.ip_address = "abc!!!"
  	end
  	before(:each) do
  		@dns_record_1 = build(:dns_record)
  		@dns_record_2 = build(:dns_record)
  		@hostname_1 = build(:hostname)
  		@hostname_2 = build(:hostname)
  	end

  	it "validates an IPV4 address before saving" do
  		expect(@invalid_record.save).to eq false
  	end
  	it "adds itself as an index to hostname model automatically" do
  		@dns_record_1.hostnames << @hostname_1
  		@dns_record_1.save
  		expect(@hostname_1.dns_records.include? @dns_record_1).to eq true
  	end
  	it "allows for multiple association of hostnames and dns records" do
  		@dns_record_1.hostnames << @hostname_1
  		@dns_record_1.hostnames << @hostname_2
  		@dns_record_2.hostnames << @hostname_1
  		@dns_record_2.hostnames << @hostname_2
  		@dns_record_1.save # all of the above should be persisted by this point
  		h1 = @dns_record_1.hostnames
  		h2 = @dns_record_2.hostnames
  		expect(h1.include?(@hostname_1) && h1.include?(@hostname_2) && h2.include?(@hostname_1) && h2.include?(@hostname_2)).to eq true
  	end
  end
end
