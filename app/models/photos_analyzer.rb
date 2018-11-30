class PhotosAnalyzer

  def self.recognize(photo_path)
    cmd = TTY::Command.new
    tensor_path = [Rails.root,'lib','tensor_models','tutorials','image','imagenet'].join('/')
    out,err = cmd.run("cd #{tensor_path} && python3 classify_image.py --image_file=#{photo_path}")
    result = []
    out.split(', ').map{|i|
      i.split("\n").map{|y| 
        stuff, score = y.split(' (score = ')
        result << stuff if score.nil? or score.to_f > 0.1
      }
    }
    result
  end

end