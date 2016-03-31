# Copyright (c) 2016 Ricoh Company, Ltd. All Rights Reserved.
# See LICENSE for more information

module Concerns
  module RicohApiAccess
    extend ActiveSupport::Concern

    included do
      before_filter :require_authentication
      before_filter :refresh_session_if_expired!
      rescue_from(
        RicohAPI::MStorage::Client::Unauthorized,
        Rack::OAuth2::Client::Error,
        with: :require_re_login
      )
    end

    protected

    def storage_api_client
      @storage_client ||= RicohAPI::MStorage::Client.new(
        current_account.access_token
      )
    end

    private

    def require_re_login(e)
      flash[:warning] = e.message
      unauthenticate!
      redirect_to root_url
    end

    def refresh_session_if_expired!
      current_account.refresh_session_if_expired!
    end
  end
end