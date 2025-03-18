class ArticleFinder
  def initialize(text_query:, page:, per_page:)
    @text_query = text_query
    @page = page
    @per_page = per_page
  end

  def call
    Article.search(text_query, order: { _score: :desc }, page:, per_page:,
                   fields: [ "title^10", "excerpt^5", "meta_description", "meta_title", "tag_names", "tag_descriptions" ])
  end

  private

  attr_reader :text_query, :page, :per_page
end
