class Course < ApplicationRecord
  belongs_to :user
  has_many :sections

  mount_uploader :image, ImageUploader

  validates :title, presence: true, length: { minimum: 5, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 5000 }
  validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
