class Item < ApplicationRecord
    include ImageUploader::Attachment(:image)
    validates :name, presence: true
    self.locking_column = :lock_version
end
