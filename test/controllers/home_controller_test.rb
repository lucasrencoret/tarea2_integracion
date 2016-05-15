require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    #post "/tags", params: { buscar: "santiago", access_token: "2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402"}
    get :index
    assert_response :success
  end
  
  test "render correcto" do
    post :tags, tag: 'santiago', access_token: '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402'
    assert_response :success
    
  end
  
  test "render error" do
    post :tags #sin params
    assert_response 400
  
  end
  
  test "probar el contar" do
    assert_not_equal false, @controller.send(:contar, 'santiago', '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402')
  end
  
  test "probar el arreglo" do
    assert_not_equal false, @controller.send(:arreglo, 'santiago', '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402')
  end
  #get "/tags", params: {buscar: "santiago", access_token: "2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402"}
  #test "access token" do
  #  client = params[:access_token]
  #  assert_equal(client, '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402')
  #end
end
