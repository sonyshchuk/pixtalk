class Photo < ApplicationRecord
  belongs_to :room
  mount_base64_uploader :path, PictureUploader

  def detect_geo_coordinates
    require 'exiftool'

    e = Exiftool.new(path.file.file)
    exif = e.to_hash.slice(:gps_longitude, :gps_latitude)

    return exif.values if [:gps_longitude, :gps_latitude].all? {|s| exif.key? s }

    # Amsterdam coast
    [52.2702, 4.4752]
  end

end
