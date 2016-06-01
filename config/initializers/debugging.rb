if Rails.env.development?
  Rack::OAuth2.logger = Rails.logger
  Rack::OAuth2.debug!
end