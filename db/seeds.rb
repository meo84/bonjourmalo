# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'json'

posts = JSON.parse(File.read("#{Rails.root}/db/seed_sources/articles.json"), symbolize_names: true)[:posts]

def add_tag_to_article(tag_details:, primary_tag: false, article:)
  tag = Tag.find_or_create_by(name: tag_details[:name]) do |new_tag|
    raw_attributes = %i[slug description visibility]
    attributes = tag_details.slice(*raw_attributes).merge(
      { feature_image_url: tag_details[:feature_image] }
    )
    new_tag.attributes = attributes
  end

  ArticlesTag.find_or_create_by(article_id: article.id, tag_id: tag.id) do |new_link|
    new_link.primary = true if primary_tag
  end
end

posts.each do |post|
  article = Article.find_or_create_by(uuid: post[:uuid]) do |new_article|
    raw_attributes = %i[title slug featured visibility published_at url excerpt reading_time access comments og_title meta_title meta_description feature_image_alt feature_image_caption]
    attributes = post.slice(*raw_attributes).merge(
      { og_image_url: post[:og_image], feature_image_url: post[:feature_image] }
    )
    new_article.attributes = attributes
  end

  post_primary_tag = post[:primary_tag]
  if post_primary_tag && !post_primary_tag[:name].start_with?('#')
    add_tag_to_article(tag_details: post_primary_tag, primary_tag: true, article:)
  end

  post_tags = post[:tags].uniq { |t| t[:name] }.reject { |t| t[:name].start_with?('#') }
  post_tags.each { |post_tag| add_tag_to_article(tag_details: post_tag, article:) }
end

Article.reindex
