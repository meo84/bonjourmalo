class ArticlesTag < ApplicationRecord
  belongs_to :article
  belongs_to :tag

  validates :primary, uniqueness: { scope: :article_id, message: "only one primary tag allowed per article" }
end
