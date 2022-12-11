class RemoveSellerIdFromInventories < ActiveRecord::Migration[7.0]
  def change
    remove_column :inventories, :seller_id
  end
end
