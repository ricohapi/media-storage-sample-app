# Copyright (c) 2016 Ricoh Company, Ltd. All Rights Reserved.
# See LICENSE for more information

class SessionsController < ApplicationController
  def create
    account = Account.authenticate!(
      params[:username],
      params[:password]
    )
    authenticate account
    redirect_to images_url
  rescue => e
    # NOTE: for developers, showing any API errors. not for production use.
    authentication_required! e
  end

  def destroy
    unauthenticate!
    redirect_to root_url
  end
end
