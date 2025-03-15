class CreateArticles < ActiveRecord::Migration[8.0]
  def change
    create_table :articles do |t|
      t.string :uuid, null: false, index: { unique: true }
      t.string :title
      t.string :slug
      t.boolean :featured
      t.column :visibility, :visibility_status, default: 'internal'
      t.datetime :published_at
      t.string :url
      t.text :excerpt
      t.integer :reading_time
      t.boolean :access
      t.boolean :comments
      t.string :og_image_url
      t.string :og_title
      t.string :meta_title
      t.text :meta_description
      t.string :feature_image_url
      t.string :feature_image_alt
      t.text :feature_image_caption

      t.timestamps
    end
  end
end
