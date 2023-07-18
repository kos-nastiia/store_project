class Product < ApplicationRecord
  has_many :product_orders, dependent: :destroy
  has_many :orders, through: :product_orders

  validates :title, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :balance, numericality:  { greater_than_or_equal_to: 0 }

  scope :ordered, -> { order(title: :asc) }
end
