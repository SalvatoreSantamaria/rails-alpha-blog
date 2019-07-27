class CreateArticles2 < ActiveRecord::Migration[5.2]
  def change
    create_table :articles2s do |t|
      t.string :title
      t.text :description
      t.timestamps
    end
  end
end
