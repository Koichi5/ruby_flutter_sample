class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :publisher, null: false
      t.string :description, null: false
      t.integer :page_count, null: false
      t.string :image_url, null: false

      t.timestamps
    end
  end
end
