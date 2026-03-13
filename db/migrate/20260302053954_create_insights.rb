class CreateInsights < ActiveRecord::Migration[8.0]
  def change
    create_table :insights do |t|
      t.integer :user_id
      t.string :title
      t.text :body
      t.string :category

      t.timestamps
    end
  end
end
