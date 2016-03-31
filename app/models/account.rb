# Copyright (c) 2016 Ricoh Company, Ltd. All Rights Reserved.
# See LICENSE for more information

class Account < ActiveRecord::Base
  include Concerns::RicohId

  def refresh_session_if_expired!
    if ricoh_session.expired? && refresh_token.present?
      access_token = refresh_ricoh_session!
      update! access_token: access_token.access_token
    end
  end

  class << self
    def authenticate!(username, password)
      access_token = authenticate_ricoh_id username, password
      account = Account.where(identifier: access_token.subject).first_or_initialize
      account.ricoh_session = access_token
      account.save!
      account
    end
  end
end
