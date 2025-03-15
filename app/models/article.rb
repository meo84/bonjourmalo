class Article < ApplicationRecord
  validates :uuid, presence: true, uniqueness: true

  has_many :articles_tags, dependent: :destroy
  has_many :tags, through: :articles_tags

  has_one :primary_articles_tag, -> { where(primary: true) }, class_name: "ArticleTag"
  has_one :primary_tag, through: :primary_articles_tag, source: :tag
end
