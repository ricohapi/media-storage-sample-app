# Copyright (c) 2016 Ricoh Company, Ltd. All Rights Reserved.
# See LICENSE for more information

class Image::ContentsController < ApplicationController
  include Concerns::RicohApiAccess

  def show
    data = storage_api_client.download(params[:image_id])
    send_data data, type: 'image/jpeg', disposition: 'inline'
  end
end
