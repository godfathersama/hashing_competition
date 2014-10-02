require 'test_helper'

class HashesControllerTest < ActionController::TestCase
  test "should get attempt" do
    get :attempt
    assert_response :success
  end

end
