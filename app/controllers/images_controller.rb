class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def show
    @image = Image.find(params[:id])
  end

  def index
    @images = Image.all
    @images = tag_param[:tag] ? @images.tagged_with(tag_param[:tag]) : @images
    @images = @images.order('created_at DESC')
  end

  def create
    create_image

    if @image.save
      flash[:notice] = 'Image successfully created'
      redirect_to @image
    else
      render :new
    end
  end

  private

  def create_image
    @image = Image.new(link: image_params[:link])
    @image.tag_list.add(image_params[:tag_list], parse: true)
  end

  def image_params
    params.require(:image).permit(:link, :tag_list)
  end

  def tag_param
    params.permit(:tag)
  end
end
