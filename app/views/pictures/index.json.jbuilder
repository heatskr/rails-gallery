json.array!(@pictures) do |picture|
  json.extract! picture, :id, :title, :description, :image, :album_id
  json.url picture_url(picture, format: :json)
end
