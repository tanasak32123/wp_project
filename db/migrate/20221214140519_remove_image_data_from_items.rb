class RemoveImageDataFromItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :items, :image_data, :text
  end
end
