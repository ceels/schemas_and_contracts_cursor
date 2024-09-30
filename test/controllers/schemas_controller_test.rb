require "test_helper"

class SchemasControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get schemas_show_url
    assert_response :success
  end
end
