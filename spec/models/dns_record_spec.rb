require 'rails_helper'

RSpec.describe DnsRecord, type: :model do
  describe "validates attributes" do
  	before(:all) do
  		@invalid_record = build(:dns_record)
  	end
  	before(:each) do
  		@dns_record_1 = build(:dns_record)
  		@dns_record_2 = build(:dns_record)
  		@hostname_1 = build(:hostname)
  		@hostname_2 = build(:hostname)
  	end

  	it "validates an IPV4 address before saving" do
  		@invalid_record.ip_address = "abc!!!"
  		expect(@invalid_record.save).to eq false
  	end
  	it "adds itself as an index to hostname model automatically" do
  		@dns_record_1.hostnames << @hostname_1
  		@dns_record_1.save
  		expect(@hostname_1.dns_records.include? @dns_record_1).to eq true
  	end
  end
end
