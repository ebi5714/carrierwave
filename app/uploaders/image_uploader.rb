class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # envで分けたい時
  # storage if Rails.env.development? ? :file : :fog
  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process resize_to_fit: [150, 150]

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
