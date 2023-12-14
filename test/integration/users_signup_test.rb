require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: {user: {name: "",
                                       email: "user@invalid",
                                       password: "foo", 
                                       password_confirmation: "bar"} }
    end
    assert_template 'users/new'
    #assert_select 'div#<CSS id for error explanation>'
    #assert_select 'div.<CSS class for field with error>'
    assert_select 'div#error_explanation'     # 1. id="error_explanationが存在するか
    assert_select 'div.alert'                            # 2.1. class="alert"が存在するか
    assert_select 'div.alert-danger' 
    assert_select 'form[action="/signup"]'
  end
end
