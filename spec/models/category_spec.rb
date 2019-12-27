require "rails_helper"

RSpec.describe Category, type: :model do
  context "Associations test" do
    it{is_expected.to have_many :products}
  end

  context "Columns test" do
    it{is_expected.to have_db_column(:name).of_type :string}
    it{is_expected.to have_db_column(:parent_id).of_type :integer}
  end

  context "Validations test" do
    it{is_expected.to validate_presence_of :name}
    it{is_expected.to validate_length_of(:name).is_at_most 100}
  end

  context "Scopes test" do
    let!(:category) {FactoryBot.create :category}

    it "Select category" do
      expect(Category.select_category).to eq [category]
    end

    it "Select category by sort desc" do
      expect(Category.create_desc).to eq [category]
    end

    it "Select category by parent id" do
      expect(Category.select_categories_parent category.parent_id).to eq [category]
    end

    it "Select category by parent id not found" do
      expect(Category.select_categories_parent category.parent_id).to be_truthy
    end

    it "Select category by sort desc parent id" do
      expect(Category.select_desc_parent).to eq [category]
    end
  end
end
