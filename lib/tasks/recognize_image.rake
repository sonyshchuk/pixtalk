namespace :recognize_image do

  desc "Provide translation"
  task now: :environment do
    file_path = [Rails.root,'public','table.jpg'].join('/')
    cmd = TTY::Command.new
    tensor_path = [Rails.root,'lib','tensor_models','tutorials','image','imagenet'].join('/')
    out,err = cmd.run("cd #{tensor_path} && python3 classify_image.py --image_file=#{file_path}")
  end

end