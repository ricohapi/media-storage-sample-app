# Copyright (c) 2016 Ricoh Company, Ltd. All Rights Reserved.
# See LICENSE for more information

class Globalizable
  module String
    def t(options = {})
      I18n.t self, options
    end
  end

  module DateAndTime
    def l(options = {})
      I18n.l self, options
    end
  end

  class << self
    def init
      ::String.include Globalizable::String
      ::Date.include Globalizable::DateAndTime
      ::Time.include Globalizable::DateAndTime
    end
  end
end