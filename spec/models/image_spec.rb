require "rails_helper"

RSpec.describe Image, type: :model do
  context "Associations test" do
    it{is_expected.to belong_to :product}
  end

  context "Columns test" do
    it{is_expected.to have_db_column(:image_link).of_type :string}
    it{is_expected.to have_db_column(:product_id).of_type :integer}
  end

  context "Validations test" do
    it{is_expected.to validate_presence_of :image_link}
  end
end
