class ArticlesController < ApplicationController
  ARTICLES_PER_PAGE = 10

  before_action do |controller|
    head :unprocessable_entity if controller.safe_params&.failure?
  end

  schema(:index) do
    optional(:query).filled(:string)
    optional(:page).filled(:integer)
  end

  def index
    @articles = if query_param
      ArticleFinder.new(text_query: query_param, page: safe_params[:page] || 1, per_page: ARTICLES_PER_PAGE).call
    else
      Article.all.order(published_at: :desc).page(safe_params[:page] || 1).per(ARTICLES_PER_PAGE)
    end

    @next_page = @articles.next_page

    respond_to do |format|
      format.html
      format.turbo_stream
      format.json { render json: params[:query] ? @articles.results : @articles }
    end
  end

  private

  def query_param
    safe_params[:query]
  end
end
