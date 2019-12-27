require "rails_helper"

RSpec.describe OrderDetail, type: :model do
  context "Associations test" do
    it{is_expected.to belong_to :order}
    it{is_expected.to belong_to :product}
  end

  context "Columns test" do
    it{is_expected.to have_db_column(:quantity).of_type :integer}
    it{is_expected.to have_db_column(:price).of_type :float}
    it{is_expected.to have_db_column(:total_price).of_type :float}
    it{is_expected.to have_db_column(:order_id).of_type :integer}
    it{is_expected.to have_db_column(:product_id).of_type :integer}
  end

  context "Validations test" do
    it{is_expected.to validate_presence_of :quantity}
    it{is_expected.to validate_presence_of :price}
    it{is_expected.to delegate_method(:id).to(:product).with_prefix true}
    it{is_expected.to delegate_method(:name).to(:product).with_prefix true}
    it{is_expected.to delegate_method(:price).to(:product).with_prefix true}
  end

  context "Scopes test" do
    let!(:account) {FactoryBot.create :account}
    let!(:product) {FactoryBot.create :product}
    let!(:order)  {FactoryBot.create :order, account: account}
    let!(:order_detail) {FactoryBot.create :order_detail, product: product, order: order}

    it "Select order detail" do
      expect(OrderDetail.select_order_detail).to eq [order_detail]
    end

    it "Select order detail by order" do
      expect(OrderDetail.select_order_detail_by_order order.id).to eq [order_detail]
    end

    it "Select order detail by order not found" do
      expect(OrderDetail.select_order_detail_by_order order.id).to be_truthy
    end

    it "Select order detail by created at" do
      expect(OrderDetail.created_between "2018-11-26", "2018-11-26").to eq [order_detail]
    end

    it "Select order detail by created at not found" do
      expect(OrderDetail.created_between "2018-11-26", "2018-11-26").to be_truthy
    end
  end
end
