FactoryBot.define do
  factory :hostname do
    address { FFaker::Internet.domain_name }
  end
end
