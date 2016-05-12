class HomeController < ApplicationController
  def index
        @instagram = Instagram.user_recent_media("1174377623", {:count => 1})
        

  end
  
  def tags
  
  @client = Instagram.client(:access_token => session[:access_token])
  tags = @client.tag_search('cat')
  

  
  end
end
