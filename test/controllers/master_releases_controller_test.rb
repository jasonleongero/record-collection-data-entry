require 'test_helper'

class MasterReleasesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get master_releases_new_url
    assert_response :success
  end

end
