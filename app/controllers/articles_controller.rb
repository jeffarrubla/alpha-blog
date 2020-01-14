class ArticlesController < ApplicationController
	def new
		@article = Article.new
	end

	def create
		#render plain: params[:article].inspect # To see what we are getting
		@article = Article.new(article_params)
		@article.save
		redirect_to articles_show(@article)
	end

	private
		def article_params
			params.require(:article).permit(:title, :description)
		end
end