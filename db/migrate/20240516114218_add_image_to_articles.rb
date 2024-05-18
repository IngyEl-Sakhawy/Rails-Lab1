class AddImageToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :image, :blob
  end
end
