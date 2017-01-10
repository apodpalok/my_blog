class ArticlesController < ApplicationController
  before_action :find_id, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @articles = if params[:tag]
                  Article.tagged_with(params[:tag])
                else
                  Article.all
                end
  end

  def show; end

  def new
    @article = current_user.articles.new
  end

  def edit; end

  def create
    @article = current_user.articles.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, :image, :all_tags)
  end

  def find_id
    @article = Article.find(params[:id])
  end
end
