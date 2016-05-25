# Copyright (c) 2016 Ricoh Company, Ltd. All Rights Reserved.
# See LICENSE for more information

class ImagesController < ApplicationController
  include Concerns::RicohApiAccess

  def index
    @images = storage_api_client.list params
  end

  def show
    @image = storage_api_client.info params[:id]
    @image_meta = storage_api_client.meta params[:id]
    # @image_tags = storage_api_client.tags_on params[:id]
  end

  def create
    image = storage_api_client.upload content: params[:file].open
    redirect_to image_url(image[:id])
  end

  def destroy
    storage_api_client.delete params[:id]
    redirect_to images_url
  end
end
