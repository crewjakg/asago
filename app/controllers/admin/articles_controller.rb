#coding: utf-8

class Admin::ArticlesController < Admin::Base

# 記事一覧
def index
  @articles = Article.order("released_at DESC").
  	paginate(page: params[:page],per_page: 5)

end

def show
  @article = Article.find(params[:id])
end

def new
  @article = Article.new
end

def edit
  @article = Article.find(params[:id])
end

#新規作成
def create
	@article = Article.new(article_params)
	if @article.save
		redirect_to [:admin, @article], notice: "ニュース記事を登録しました"
	else
		render "new"
	end
end

#更新
def update
	@article = Article.find(params[:id])
	#@article.assign_attributes(params[:article])
	if @article.update(article_params)
		redirect_to [:admin, @article], notice: "ニュース記事を更新しました"
	else
		render 'edit'
	end
end

#削除
def destroy
	@article = Article.find(params[:id])
	@article.destroy
	redirect_to :admin_articles, notice: "ニュース記事を削除しました"
end


private
def article_params
 params[:article].permit(:title,:body,:released_at,:expired_ad,
 :member_only)
end

end
