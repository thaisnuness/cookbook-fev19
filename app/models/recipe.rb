class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :cuisine
  has_one_attached :photo
  
  validates :title, :recipe_type, :cuisine, :difficulty,
            :cook_time, :ingredients, :cook_method, presence: true

  validates :cook_time, numericality: { greater_than: 0, message: "O tempo de preparo deve ser maior que 0" }

  def cook_time_min
    "#{cook_time} minutos"
  end
end
