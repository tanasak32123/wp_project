class User < ApplicationRecord
    has_secure_password
    self.locking_column = :lock_version
    enum :user_type, {admin: 0, seller: 1, buyer: 2}
    has_many :inventories, dependent: :destroy
    has_many :markets, dependent: :destroy
end
