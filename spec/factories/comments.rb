FactoryBot.define do
  factory :comment do
    content "this is a comment"
    product
    account
  end
end
