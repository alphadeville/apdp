class Api::ArticleController < ApplicationController

  def show
    @article = Article.find_by_src_id params[:id]
  end

  def related_links
    unless params[:slug].blank?
      @article = Article.find_by_slug params[:slug]
    else
      @article = Article.find_by_src_id params[:src_id]
    end
  end

end
