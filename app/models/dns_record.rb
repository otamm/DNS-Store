class DnsRecord < ApplicationRecord
	# ip_address->string
	has_and_belongs_to_many :hostnames

	IPV4_REGEX = /\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}\b/
	validates_format_of :ip_address, with: IPV4_REGEX
	
	before_save :include_itself_in_hostnames

	def include_itself_in_hostnames
		hostnames.each do |hostname|
			hostname.dns_records << self if !hostname.dns_records.include? self
		end
	end
end
