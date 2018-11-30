class Photo < ApplicationRecord
  belongs_to :room
  mount_uploader :path, PictureUploader
end
