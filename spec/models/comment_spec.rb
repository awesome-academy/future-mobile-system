require "rails_helper"

RSpec.describe Comment, type: :model do
  context "Associations test" do
    it{is_expected.to belong_to :account}
    it{is_expected.to belong_to :product}
  end

  context "Columns test" do
    it{is_expected.to have_db_column(:content).of_type :text}
    it{is_expected.to have_db_column(:account_id).of_type :integer}
    it{is_expected.to have_db_column(:product_id).of_type :integer}
  end

  context "Validations test" do
    it{is_expected.to validate_presence_of :content}
  end

  context "Scopes test" do
    let!(:account) {FactoryBot.create :account}
    let!(:product) {FactoryBot.create :product}
    let!(:comment) {FactoryBot.create :comment, product: product, account: account}

    it "Select comment" do
      expect(Comment.select_comment).to eq [comment]
    end

    it "Show comment by sort desc" do
      expect(Comment.show_comment_desc).to eq [comment]
    end

    it "Select comment by product" do
      expect(Comment.select_comment_product product.id).to eq [comment]
    end

    it "Select comment by product not found" do
      expect(Comment.select_comment_product product.id).to be_truthy
    end
  end
end
