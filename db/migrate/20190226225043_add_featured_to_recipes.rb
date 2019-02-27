class AddFeaturedToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :featured, :boolean
  end
end
