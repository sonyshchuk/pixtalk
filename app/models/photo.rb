class Photo < ApplicationRecord
  belongs_to :room
  mount_base64_uploader :path, PictureUploader

  def detect_geo_coordinates
    "4.4752#{rand(9)},52.2702#{rand(9)}"
  end

end
