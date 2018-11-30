class Property < ApplicationRecord

  has_many :rooms

  def generate_final_template
    process_rooms_photos
    geo_coordinates   = rooms.to_a.map(&:photos).flatten.first.detect_geo_coordinates
    price_per_night   = generate_price_per_night(geo_coordinates)
    address           = detect_address(geo_coordinates)
    {
      id: id,
      address: address,
      rooms: rooms,
      price_per_night: price_per_night
    }
  end

  def process_rooms_photos
    rooms.to_a.map(&:process_photos!)
  end

  def generate_price_per_night(geo_coordinates)
    region_url  = "http://search.leisure-ict.com/api/v1/properties?distance=50&exact_location=0&latitude=#{geo_coordinates.last}&longitude=#{geo_coordinates.first}"
    result      = JSON.parse(RestClient.get(region_url))
    region_code = result["properties"].first["country_regions"].first['code']
    
    price_url   = "http://search.leisure-ict.com/api/v1/properties?region_id=#{region_code}&per_page=200"
    result      = JSON.parse(RestClient.get(price_url))
    prices      = result['properties'].map{|p| p['price']['price']}
    
    average_price = prices.sum / prices.size.to_f
    average_price = (average_price / 7.0).round
    average_price - (average_price * 0.20)
  end

  def detect_address(geo_coordinates)
    if data = Geocoder.search(geo_coordinates.reverse).first.try(:data)
      {
        country: data['address']['country'],
        region: data['address']['state'],
        city: data['address']['city'],
      }
    end
  end

end
