require 'test_helper'

class SignupUsersTest < ActionDispatch::IntegrationTest

	test "should sign up new user" do 
		get signup_path
		assert_template 'users/new'
		assert_difference 'User.count', 1 do
			post users_path, params: {user: {username: "fido", email: 'fido@fido.com', password: "fido"}}
			follow_redirect!
		end
		assert_template 'users/show'
		assert_match 'fido', response.body
	end

	test "missing password on submittion doesn't allow user creation" do
		get signup_path
		assert_template 'users/new'
		assert_no_difference 'User.count' do
			post users_path, params: {user: {username: "fido", email: 'fido@fido.com', password: ""}}			
		end
		assert_template 'users/new'
		assert_select 'h2.card-title.center'
		assert_select 'div.card-body'
	end

	test "duplicated username does't allow user creation" do
		get signup_path
		assert_template 'users/new'
		post users_path, params: {user: {username: "fido", email: 'fido@fido.com', password: "fido"}}
		get signup_path
		assert_template 'users/new'
		assert_no_difference 'User.count' do
			post users_path, params: {user: {username: "fido", email: 'fido@fido.com', password: "joes"}}			
		end
		assert_template 'users/new'
		assert_select 'h2.card-title.center'
		assert_select 'div.card-body'
	end
end
