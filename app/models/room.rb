class Room < ApplicationRecord
  belongs_to :property
  has_many :photos
  attr_accessor :photo_data

  def process_photos!
    self.amenities = photos.to_a.map{|p| PhotosAnalyzer.recognize(p.path.path) }.flatten
    self.save
    self.amenities
  end

end
