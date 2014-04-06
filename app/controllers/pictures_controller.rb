class PicturesController < ApplicationController
  before_action :set_album
  before_action :set_picture, only: [:show, :update, :destroy]

  def index
    @pictures = @album.pictures
    respond_to do |format|
      format.json do
        render json: @pictures.map{ |picture| picture.to_jq_upload }
      end
    end
  end

  def show; end

  def create
    @picture = @album.pictures.new(picture_params)
    respond_to do |format|
      if @picture.save
        format.json { render json: {files: [@picture.to_jq_upload]}, status: :created, location: [@album, @picture] }
      else
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.json { head :no_content }
      else
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @picture.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

private
  def set_album
    @album = Album.find(params[:album_id])
  end

  def set_picture
    @picture = @album.pictures.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(:title, :description, :image, :album_id)
  end
end
