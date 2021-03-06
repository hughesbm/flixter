class Lesson < ApplicationRecord
  belongs_to :section

  mount_uploader :video, VideoUploader

  validates :title, presence: true, length: { minimum: 3, maximum: 30 }
  validates :subtitle, presence: true, length: { minimum: 3, maximum: 30 }
  validates :additional_notes, length: { maximum: 2000 }

  include RankedModel
  ranks :row_order, with_same: :section_id

  def next_lesson
    lesson = section.lessons.where("row_order > ?", self.row_order).rank(:row_order).first
    if lesson.blank? && section.next_section
      return section.next_section.lessons.rank(:row_order).first
    end
    return lesson
  end

  def previous_lesson
    lesson = section.lessons.where("row_order < ?", self.row_order).rank(:row_order).last
    if lesson.blank? && section.previous_section
      return section.previous_section.lessons.rank(:row_order).last
    end
    return lesson
  end
end
