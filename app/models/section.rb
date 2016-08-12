class Section < ApplicationRecord
  belongs_to :course
  has_many :lessons

  validates :title, presence: true, length: { minimum: 3, maximum: 30 }
end
