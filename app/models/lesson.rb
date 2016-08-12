class Lesson < ApplicationRecord
  belongs_to :section

  validates :title, presence: true, length: { minimum: 3, maximum: 30 }
  validates :subtitle, presence: true, length: { minimum: 3, maximum: 30 }
end
