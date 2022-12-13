class AddItemToInventories < ActiveRecord::Migration[7.0]
  def change
    add_reference :inventories, :item, null: false, foreign_key: true
  end
end
