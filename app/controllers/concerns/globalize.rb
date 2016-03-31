# Copyright (c) 2016 Ricoh Company, Ltd. All Rights Reserved.
# See LICENSE for more information

module Concerns
  module Globalize
    extend ActiveSupport::Concern

    included do
      before_filter :set_locale
    end

    def set_locale
      accepted_languages = request.env['HTTP_ACCEPT_LANGUAGE']
      if accepted_languages.present?
        I18n.locale = accepted_languages.split(',').collect do |lang|
          lang[0, 2]
        end.detect do |locale|
          I18n.available_locales.include? locale.to_sym
        end
      end
    end
  end
end