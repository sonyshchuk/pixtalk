class Photo < ApplicationRecord
  belongs_to :room
  mount_base64_uploader :path, PictureUploader

  def detect_geo_coordinates
    require 'exiftool'

    e = Exiftool.new(path.file.file)
    e.to_hash.slice(:gps_longitude, :gps_latitude).values.join(',')
  end

end
