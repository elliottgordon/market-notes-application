class CreateNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :notes do |t|
      t.integer :user_id
      t.string :title
      t.text :body
      t.date :market_date

      t.timestamps
    end
  end
end
