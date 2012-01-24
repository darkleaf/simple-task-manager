class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.text :body
      t.integer :owner_id
      t.integer :responsible_user_id

      t.timestamps
    end
  end
end
