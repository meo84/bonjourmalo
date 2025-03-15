class CreateArticlesTags < ActiveRecord::Migration[8.0]
  def change
    create_table :articles_tags do |t|
      t.references :article, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
      t.boolean :primary, default: false

      t.timestamps
    end
    add_index :articles_tags, [ :article_id, :tag_id ], unique: true
    add_index :articles_tags, [ :article_id, :primary ], unique: true, where: "articles_tags.primary = true"
  end
end
