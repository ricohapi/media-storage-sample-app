# Copyright (c) 2016 Ricoh Company, Ltd. All Rights Reserved.
# See LICENSE for more information

module Concerns
  module Authentication
    extend ActiveSupport::Concern

    class AuthenticationRequired < StandardError; end
    class AnonymousAccessRequired < StandardError; end

    included do
      before_filter :optional_authentication
      helper_method :current_account, :authenticated?
      rescue_from AuthenticationRequired,  with: :authentication_required!
      rescue_from AnonymousAccessRequired, with: :anonymous_access_required!
    end

    def current_account
      @current_account
    end

    def authenticated?
      !current_account.blank?
    end

    def authentication_required!(e)
      redirect_to root_url, flash: {
        warning: e.message
      }
    end

    def anonymous_access_required!(e)
      redirect_to images_url
    end

    def optional_authentication
      if session[:current_account]
        authenticate Account.find_by_id(session[:current_account])
      end
    rescue ActiveRecord::RecordNotFound
      unauthenticate!
    end

    def require_authentication
      unless authenticated?
        session[:after_logged_in_endpoint] = request.url if request.get?
        raise AuthenticationRequired.new
      end
    end

    def require_anonymous_access
      raise AnonymousAccessRequired.new if authenticated?
    end

    def authenticate(account)
      if account
        @current_account = account
        session[:current_account] = account.id
      end
    end

    def unauthenticate!
      @current_account = session[:current_account] = nil
    end
  end
end