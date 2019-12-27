require "rails_helper"

RSpec.describe Account, type: :model do
  context "Associations test" do
    it{is_expected.to have_many :orders}
    it{is_expected.to have_many :comments}
  end

   context "Columns test" do
    it{is_expected.to have_db_column(:fullname).of_type :string}
    it{is_expected.to have_db_column(:email).of_type :string}
    it{is_expected.to have_db_column(:phone).of_type :string}
    it{is_expected.to have_db_column(:address).of_type :string}
    it{is_expected.to have_db_column(:account_type).of_type :integer}
  end

   context "Validations test" do
    it{is_expected.to validate_presence_of :fullname}
    it{is_expected.to validate_length_of(:fullname).is_at_most 50}
    it{is_expected.to validate_presence_of :email}
    it{is_expected.to validate_length_of(:email).is_at_most 200}
    it{is_expected.to validate_uniqueness_of(:email).case_insensitive}
    it{is_expected.to define_enum_for(:account_type).with [:member, :admin]}
  end
end
