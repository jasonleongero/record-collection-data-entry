require 'test_helper'

class ArtistsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get artists_new_url
    assert_response :success
  end

end
