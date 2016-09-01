class AlterLessonsAddAdditionalNotes < ActiveRecord::Migration[5.0]
  def change
    add_column :lessons, :additional_notes, :text
  end
end
