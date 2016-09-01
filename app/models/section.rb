class Section < ApplicationRecord
  belongs_to :course
  has_many :lessons

  validates :title, presence: true, length: { minimum: 3, maximum: 30 }

  include RankedModel
  ranks :row_order, with_same: :course_id

  def next_section
    return course.sections.where("row_order > ?", self.row_order).rank(:row_order).first
  end

  def previous_section
    return course.sections.where("row_order < ?", self.row_order).rank(:row_order).last
  end
end
