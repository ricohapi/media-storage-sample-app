if Rails.env.development?
  RicohAPI::MStorage.logger = Rails.logger
  RicohAPI::MStorage.debug!

  Rack::OAuth2.logger = Rails.logger
  Rack::OAuth2.debug!
end