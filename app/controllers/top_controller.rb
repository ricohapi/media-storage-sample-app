# Copyright (c) 2016 Ricoh Company, Ltd. All Rights Reserved.
# See LICENSE for more information

class TopController < ApplicationController
  before_filter :require_anonymous_access

  def index
  end
end
