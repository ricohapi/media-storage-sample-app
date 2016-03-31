# Copyright (c) 2016 Ricoh Company, Ltd. All Rights Reserved.
# See LICENSE for more information

class Image::TagsController < ApplicationController
  include Concerns::RicohApiAccess

  def create
    storage_api_client.tags_to params[:image_id], params[:tag]
    redirect_to image_url(params[:image_id])
  end
end