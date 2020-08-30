require 'test_helper'

class ReleaseControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get release_new_url
    assert_response :success
  end

end
