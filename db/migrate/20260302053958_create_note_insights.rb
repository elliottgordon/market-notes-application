class CreateNoteInsights < ActiveRecord::Migration[8.0]
  def change
    create_table :note_insights do |t|
      t.integer :note_id
      t.integer :insight_id

      t.timestamps
    end
  end
end
