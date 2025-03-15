require 'rails_helper'

describe ArticlesController, type: :controller do
  it 'returns a 422 when query is not valid' do
    get :index, format: :json, params: { query: [ 'not', 'valid' ] }
    expect(response.status).to eq 422
  end

  context 'with no search query' do
    it 'returns all articles ordered from newest to oldest' do
      old_article = create(:article, published_at: 2.days.ago)
      new_article = create(:article, published_at: Time.now)

      get :index, format: :json

      article_ids = response.parsed_body.map { |a| a['id'].to_i }
      expect(article_ids). to eq [ new_article.id, old_article.id ]
    end
  end

  context 'with search query' do
    it 'returns articles matching search query sorted by relevance' do
      irrelevant_article = create(:article, title: 'Alimentation 0-12 mois')
      relevant_article = create(:article, title: 'Perfectionnisme parental : comment ne pas être trop exigeant ?', excerpt: 'Le perfectionnisme peut être une qualité précieuse : il nous permet d’avoir l’élan pour nous améliorer jour après… notamment avec nos ados')
      very_relevant_article = create(:article, title: 'Ados et écrans', excerpt: 'Les écrans sont partout, et nos enfants (pardon nos ados) y passent une grande partie de leur temps….')

      Article.reindex
      get :index, params: { query: 'Ados' }, format: :json

      article_ids = response.parsed_body.map { |a| a['id'].to_i }
      expect(article_ids). to eq [ very_relevant_article.id, relevant_article.id ]
    end
  end
end
