FactoryBot.define do
  factory :order do
    status 0
    phone "11111111111"
    address "Ninh Binh"
    total 10000
    account
  end
end
