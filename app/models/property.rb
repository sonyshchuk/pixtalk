class Property < ApplicationRecord

  has_many :rooms

  def generate_final_template
    analyzed_photos   = process_rooms_photos
    geo_coordinates   = detect_geo_coordinates(rooms.first.photos.first)
    property_id       = generate_property_id(geo_coordinates)
    price_per_night   = generate_price_per_night(geo_coordinates)
    general_amenities = detect_general_amenities(analyzed_photos)
    description       = generate_description(analyzed_photos)
  end


  def process_rooms_photos
    rooms.to_a.map(:process_photos!).flatten
  end

end
