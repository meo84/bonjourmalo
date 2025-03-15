require 'rails_helper'

describe ArticleFinder do
  it 'returns articles with matching text in title' do
    title = "La diversification alimentaire"
    article = create(:article, title:)
    create(:article, title: title.gsub("diversification", "santé"))

    Article.reindex
    articles = described_class.new(text_query: "diversification", page: 1, per_page: 10).call
    expect(articles).to contain_exactly(article)
  end

  it 'returns articles with matching text in excerpt' do
    excerpt = "La diversification de 4 à 6 mois jusqu'à 3 ans."
    article = create(:article, excerpt:)
    create(:article, excerpt: excerpt.gsub("diversification", "croissance"))

    Article.reindex
    articles = described_class.new(text_query: "diversification", page: 1, per_page: 10).call
    expect(articles).to contain_exactly(article)
  end

  it 'returns articles with matching text in meta_description' do
    meta_description = "Quelles sont les consultations obligatoire pour le suivi de votre bébé et pourquoi il ne faut pas les louper ?"
    article = create(:article, meta_description:)
    create(:article, meta_description: meta_description.gsub("consultation", "vaccin"))

    Article.reindex
    articles = described_class.new(text_query: "consultation", page: 1, per_page: 10).call
    expect(articles).to contain_exactly(article)
  end

  it 'returns articles with matching text in meta_title' do
    meta_title = "Tout comprendre sur votre bébé avec l'app heloa"
    article = create(:article, meta_title:)
    create(:article, meta_title: meta_title.gsub("bébé", "santé"))

    Article.reindex
    articles = described_class.new(text_query: "bébé", page: 1, per_page: 10).call
    expect(articles).to contain_exactly(article)
  end

  it 'returns articles with matching text in tag name' do
    tag_name = "0-12 mois"
    tag = create(:tag, name: tag_name)
    article = create(:article)
    create(:articles_tag, tag:, article:)

    other_tag = create(:tag, name: "1-3 ans")
    other_article = create(:article)
    create(:articles_tag, tag: other_tag, article: other_article)


    Article.reindex
    articles = described_class.new(text_query: tag_name, page: 1, per_page: 10).call
    expect(articles).to contain_exactly(article)
  end

  it 'returns articles with matching text in tag description' do
    tag_description = "Comprenez le développement de votre bébé qui évolue de 0 à 12 mois.\nSourire, vous faire coucou, apprendre à parler, à marcher, manger seul, l'accompagner dans la gestion de ses émotions, on vous explique tout."
    tag = create(:tag, description: tag_description)
    article = create(:article)
    create(:articles_tag, tag:, article:)

    other_article = create(:article)
    other_tag = create(:tag, description: tag_description.gsub("0 à 12 mois", "1 à 3 ans"))
    create(:articles_tag, tag: other_tag, article: other_article)


    Article.reindex
    articles = described_class.new(text_query: tag_description, page: 1, per_page: 10).call
    expect(articles).to contain_exactly(article)
  end
end
