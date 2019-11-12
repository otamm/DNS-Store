require 'rails_helper'

RSpec.describe Hostname, type: :model do
  describe "validates attributes" do
  	before(:all) do
  		@invalid_record = build(:hostname)
  		@invalid_record.address = "facebook-!!.net"
  	end
  	before(:each) do
  		@dns_record_1 = build(:dns_record)
  		@dns_record_2 = build(:dns_record)
  		@hostname_1 = build(:hostname)
  		@hostname_2 = build(:hostname)
  	end

  	it "validates domain name" do
  		expect(@invalid_record.save).to eq false
  	end
  	it "adds itself as an index to dns record model automatically" do
  		@hostname_1.dns_records << @dns_record_1
  		@hostname_1.save
  		expect(@dns_record_1.hostnames.include? @hostname_1).to eq true
  	end
  	it "allows for multiple association of hostnames and dns records" do
  		@hostname_1.dns_records << @dns_record_1
  		@hostname_1.dns_records << @dns_record_2
  		@hostname_2.dns_records << @dns_record_1
  		@hostname_2.dns_records << @dns_record_2
  		@hostname_1.save # all of the above should be persisted by this point
  		d1 = @hostname_1.dns_records
  		d2 = @hostname_2.dns_records
  		expect(d1.include?(@dns_record_1) && d1.include?(@dns_record_2) && d2.include?(@dns_record_1) && d2.include?(@dns_record_2)).to eq true
  	end
  end
end
