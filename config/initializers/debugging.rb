if Rails.env.development?
  RicohAPI::MStorage.logger = Rails.logger
  RicohAPI::MStorage.debug!
end