class Picture < ActiveRecord::Base
  belongs_to :album
  mount_uploader :image, ImageUploader

  def to_jq_upload
    {
      id: id,
      title: title,
      description: description,
      thumbnail_url: image.thumb_180.url,
      name: File.basename(image.url),
      name: File.basename(image.url),
      size: image.size,
      url: image.url,
      delete_url: "/albums/#{album_id}/pictures/#{id}.json",
      delete_type: "DELETE"
    }
  end
end
