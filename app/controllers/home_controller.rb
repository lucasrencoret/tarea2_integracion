class HomeController < ApplicationController
  def index
        @instagram = Instagram.user_recent_media("1174377623", {:count => 1})
  end
end
