require 'rails_helper'

describe ArticleFinder do
  it 'returns all articles' do
    article = create(:article)
    expect(described_class.new(text_query: 'anything').call).to contain_exactly(article)
  end
end
