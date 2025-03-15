class ArticleFinder
  def initialize(text_query:)
    @text_query = text_query
  end

  def call
    Article.all
  end
end
