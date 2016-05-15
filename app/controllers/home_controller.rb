require 'rails_param'
class HomeController < ApplicationController
  def index
  end
  
  def tags
    #response = RestClient.get 'https://api.instagram.com/v1/tags/'+params[:tag]+'/media/recent?access_token='+params[:access_token]
    
    tag = params[:tag]
    if tag.nil?
      render json: { error: "Los parametros ingresados son incorrectos" }, status: 400
      return
    end
    
    access_token = params[:access_token]
    if access_token.nil?
      render json: { error: "Los parametros ingresados son incorrectos" }, status: 400
      return
    end
    
    total = contar(tag, access_token)
    arreglo = arreglo(tag, access_token)
    
    render json:{
      metadata:{total: total},
      posts: arreglo,
      version: '1.0.2'
      
    }
  end
  #@respuesta = JSON.parse(@response)
  
  
  #@client = Instagram.client(:access_token => params[:access_token])
  #@tags = @client.tag_search(params[:buscar])
  #param! :buscar,  String, required: true
  #param! :access_token, String, is: "2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402"
  
  #for media_item in @client.tag_recent_media(@tags[0].name)
    #media_item.images.thumbnail.url
    #media_item.caption.from.full_name
    #username = media_item.caption.from.username
    #text = media_item.caption.text
    #tags = media_item.tags
    
  #end
  
  #recent_media = Instagram.tag_recent_media(params[:buscar])
  #recent_media.each do |media|
      #Photo.create(
        #link: media.link,
       # owner: media.caption.from.username,
        #thumbnail_url: media.images.thumbnail.url
      #)
    #end
  
  
  
  
  def arreglo(tag, access_token)
    respuesta = RestClient.get 'https://api.instagram.com/v1/tags/'+tag+'/media/recent?access_token='+access_token
    
    response = JSON.parse(respuesta)
    arreglo = []
   
    response['data'].each  do |post|
      
        tags = post['tags']
        username = post['caption']['from']['username'].to_s
        likes = post['likes']['count'].to_i
        url = post['images']['thumbnail']['url'].to_s
        caption = post['caption']['text'].to_s
        
        retorno = {tags: tags, username: username, likes: likes, url: url, caption: caption}
        arreglo.append(retorno) 
        
      
    end
    return arreglo
    
  end
  
  def contar(tag, access_token)
    response = RestClient.get 'https://api.instagram.com/v1/tags/'+tag+'?access_token='+access_token
	  cantidad = response['data']['media_count'].to_i
    return cantidad
  end
end
