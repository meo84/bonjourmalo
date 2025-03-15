class ArticleFinder
  def initialize(text_query:)
    @text_query = text_query
  end

  def call
    Article.search(text_query)
  end

  private

  attr_reader :text_query
end
