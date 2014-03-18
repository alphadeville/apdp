class Api::ArticleController < Api::MainController
  after_filter :allow_crossdomain

  def show
    @article = Article.find_by_src_id params[:id]
  end

  def related_links
    article_id = params[:id].to_s
    @article   = Article.where('src_id = ? OR slug = ?', article_id, article_id).first!
  end

end
