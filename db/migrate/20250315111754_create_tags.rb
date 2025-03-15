class CreateTags < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
      CREATE TYPE visibility_status AS ENUM ('internal', 'public');
    SQL

    create_table :tags do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :slug
      t.text :description
      t.string :feature_image_url
      t.column :visibility, :visibility_status, default: 'internal'

      t.timestamps
    end
  end

  def down
    drop_table :tags

    execute <<-SQL
      DROP TYPE visibility_status;
    SQL
  end
end
