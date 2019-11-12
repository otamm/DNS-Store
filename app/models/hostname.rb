class Hostname < ApplicationRecord
	# address->string
	has_and_belongs_to_many :dns_records

	DOMAIN_NAME_REGEX = /^((?!-))(xn--)?[a-z0-9][a-z0-9-_]{0,61}[a-z0-9]{0,1}\.(xn--)?([a-z0-9\-]{1,61}|[a-z0-9-]{1,30}\.[a-z]{2,})$/
	validates_format_of :ip_address, with: DOMAIN_NAME_REGEX

	before_save :include_itself_in_dns_records

	def include_itself_in_dns_records
		dns_records.each do |dns_record|
			dns_record.hostnames << self if !dns_record.hostnames.include? self
		end
	end
end
