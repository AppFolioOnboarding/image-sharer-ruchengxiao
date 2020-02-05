class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def show
    @image = Image.find(params[:id])
  end

  def index
    @images = Image.all
  end

  def create
    @image = Image.new(image_params)

    if @image.save
      redirect_to @image
    else
      render :new
    end
  end

  private

  def image_params
    params.require(:image).permit(:link, :tag)
  end
end
