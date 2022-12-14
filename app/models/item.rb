class Item < ApplicationRecord
    has_one_attached :pic
    self.locking_column = :lock_version
end
