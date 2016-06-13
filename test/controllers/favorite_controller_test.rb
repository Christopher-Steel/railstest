require 'test_helper'

class FavoriteControllerTest < ActionController::TestCase
  test "should POST create" do
    post :create, number: 1
    assert_response :success
  end

  test "should DELETE destroy" do
    get :destroy, number: 1
    assert_response :success
  end
end
