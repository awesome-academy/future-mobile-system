require "rails_helper"

RSpec.describe Order, type: :model do
  context "Associations test" do
    it{is_expected.to belong_to :account}
    it{is_expected.to have_many :order_details}
  end

  context "Columns test" do
    it{is_expected.to have_db_column(:status).of_type :integer}
    it{is_expected.to have_db_column(:phone).of_type :string}
    it{is_expected.to have_db_column(:address).of_type :string}
    it{is_expected.to have_db_column(:total).of_type :float}
    it{is_expected.to have_db_column(:account_id).of_type :integer}
  end

  context "Validations test" do
    it{is_expected.to validate_presence_of :status}
    it{is_expected.to validate_presence_of :phone}
    it{is_expected.to validate_length_of(:phone).is_at_most 15}
    it{is_expected.to validate_presence_of :address}
    it{is_expected.to validate_length_of(:address).is_at_most 255}
    it{is_expected.to delegate_method(:fullname).to(:account).with_prefix true}
  end

  context "Scopes test" do
    let!(:account) {FactoryBot.create :account}
    let!(:order) {FactoryBot.create :order, account: account}

    it "Select order" do
      expect(Order.select_order).to eq [order]
    end
  end
end
