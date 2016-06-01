# Copyright (c) 2016 Ricoh Company, Ltd. All Rights Reserved.
# See LICENSE for more information

module Concerns
  module RicohId
    extend ActiveSupport::Concern

    def ricoh_session
      @ricoh_access_token ||= RicohAPI::Auth::AccessToken.new access_token
    end

    def ricoh_session=(access_token)
      self.access_token, self.refresh_token = access_token.access_token, access_token.refresh_token
    end

    def refresh_ricoh_session!
      client = self.class.ricoh_oauth_client
      client.refresh_token = refresh_token
      client.api_token_for! RicohAPI::MStorage::SCOPE
    end

    module ClassMethods
      def ricoh_oauth_client
        RicohAPI::Auth::Client.new(
          Rails.application.secrets.ricoh_api['client_id'],
          Rails.application.secrets.ricoh_api['client_secret']
        )
      end

      def authenticate_ricoh_id(username, password)
        client = ricoh_oauth_client
        client.resource_owner_credentials = username, password
        client.api_token_for! RicohAPI::MStorage::SCOPE
      end
    end
  end
end