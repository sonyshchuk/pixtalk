class Room < ApplicationRecord
  belongs_to :property
  has_many :photos
  attr_accessor :photo_data

  def as_json(attrs={})
    {
      name: name,
      amenities: amenities.split(','),
      photos: photos.to_a.map{|p| p.path }
    }
  end

  def process_photos!
    self.amenities = photos.to_a.map{|p| PhotosAnalyzer.recognize(p.path.path) }.flatten.join(',')
    self.save
    self.amenities
  end

end
