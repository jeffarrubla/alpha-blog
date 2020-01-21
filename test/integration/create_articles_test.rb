require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest

	def setup
		@user = User.create(username: "john", email: "john@example.com", password: "password",admin: true)
	end

	test "get new article form and create article" do
		sign_in_as(@user,"password")
		get new_article_path
		assert_template 'articles/new'
		assert_difference 'Article.count', 1 do
			post articles_path, params: {article: {title: "New Title for Article", description: "New description for this article", category: Category.last}}
			follow_redirect!
		end
		assert_template 'articles/show'
		assert_match "New Title for Article", response.body
	end

	test "missing description results in failure" do
		sign_in_as(@user,"password")
		get new_article_path
		assert_template 'articles/new'
		assert_no_difference 'Article.count' do
			post articles_path, params: {article: {title: "New Title for Article", description: "", category: Category.last}}
		end
		assert_template 'articles/new'
		assert_select 'h2.card-title.center'
		assert_select 'div.card-body'
	end

	test "missing title results in failure" do
		sign_in_as(@user,"password")
		get new_article_path
		assert_template 'articles/new'
		assert_no_difference 'Article.count' do
			post articles_path, params: {article: {title: "", description: "New Description for Article", category: Category.last}}
		end
		assert_template 'articles/new'
		assert_select 'h2.card-title.center'
		assert_select 'div.card-body'
	end

end