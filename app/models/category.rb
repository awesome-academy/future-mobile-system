class Category < ApplicationRecord
  extend OpenSpreadsheet

  has_many :products, dependent: :destroy
  validates :name, presence: true,
    length: {maximum: Settings.size.length_name_category}
  scope :select_category, -> {select :id, :name, :parent_id}
  scope :create_desc, -> {order created_at: :desc}
  scope :select_categories_parent, ->(parent_id){where parent_id: nil}
  scope :select_desc_parent, -> {order parent_id: :asc}
  scope :select_category_create, ->{where "parent_id IS NOT NULL"}

  private

  class << self
    def import file
      import_file file, ["name", "parent_id"]
    end
  end
end
