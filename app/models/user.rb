class User < ApplicationRecord
    has_secure_password
    enum :user_type, {admin: 0, seller: 1, buyer: 2}
    has_many :inventories, dependent: :destroy
end
