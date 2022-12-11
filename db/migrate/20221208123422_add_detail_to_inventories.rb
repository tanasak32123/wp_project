class AddDetailToInventories < ActiveRecord::Migration[7.0]
  def change
    add_column :inventories, :seller_id, :integer, null: false
    add_foreign_key :inventories, :users, column: :seller_id, primary_key: :id
  end
end
