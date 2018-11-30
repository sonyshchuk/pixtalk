class Property < ApplicationRecord

  has_many :rooms

  def generate_final_template
    analyzed_photos   = process_rooms_photos
    geo_coordinates   = detect_geo_coordinates(rooms.to_a.map(&:photos).flatten)
    property_id       = generate_property_id(geo_coordinates)
    price_per_night   = generate_price_per_night(geo_coordinates)
    general_amenities = detect_general_amenities(analyzed_photos)
    description       = generate_description(analyzed_photos)
  end

  def process_rooms_photos
    rooms.to_a.map(:process_photos!).flatten
  end

  def generate_price_per_night
    #photos.map(&:detect_geo_coordinates).compact.first(3)
    main_url = "http://87.233.77.180:81/api/v1/properties?persons=#{persons}&nights=#{7}&exact_location=1&facets=_default%2Cbathrooms%2Cstars%2Cwith_discount&fields=id%2Cprice&locale=en&page=1&per_page=300&platform=bvmobapp"
    polygon_points = []
    ["4.4752#{rand(9)},52.2702#{rand(9)}","4.4752#{rand(9)},52.2702#{rand(9)}","4.4752#{rand(9)},52.2702#{rand(9)}"].each_with_index{|c,i|
      "polygon_points[#{i}]=#{c}"
    }
    result        = JSON.parse(RestClient.get(main_url + '&' + polygon_points.join('&')))
    prices        = result['properties'].map{|p| p['price']['price']}
    average_price = prices.sum / prices.size.to_f
    average_price = (average_price / 7).round
    average_price - (average_price * 0.20)
  end

end
