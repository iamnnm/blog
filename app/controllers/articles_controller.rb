# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article

  def index
    @articles = Article.all.order(created_at: :desc)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, success: 'Post has created!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      redirect_to @article, success: 'Post has updated!'
    else
      render :edit
    end
  end

  def show; end

  def destroy
    if @article.nil?
      redirect_to root_path
    else
      @article.destroy

      redirect_to articles_path, success: 'Post has deleted!'
    end
  end

  private

  def set_article
    @article ||= Article.find_by(id: params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
