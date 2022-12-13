class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :seller_id
      t.float :price
      t.integer :qty

      t.timestamps
    end
  end
end
