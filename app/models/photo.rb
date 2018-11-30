class Photo < ApplicationRecord
  belongs_to :room
  mount_base64_uploader :path, PictureUploader
end
