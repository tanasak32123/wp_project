class Item < ApplicationRecord
    include ImageUploader::Attachment(:image)
    validates :name, presence: true
end
