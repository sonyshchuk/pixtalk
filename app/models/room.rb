class Room < ApplicationRecord
  belongs_to :property
  has_many :photos
  attr_accessor :photo_data

  def process_photos!
    photos.to_a.map{|p| PhotosAnalyzer.recognize(p.path) }.flatten
  end

end
