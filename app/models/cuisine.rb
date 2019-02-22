class Cuisine < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { message: "O nome informado já existe!" }
end
