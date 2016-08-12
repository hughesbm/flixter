class Section < ApplicationRecord
  belongs_to :course

  validates :title, presence: true, length: { minimum: 3, maximum: 30 }
end
