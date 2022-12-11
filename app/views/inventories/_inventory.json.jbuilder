json.extract! inventory, :id, :user_id, :seller_id, :price, :qty, :item_id, :created_at, :updated_at
json.url inventory_url(inventory, format: :json)
