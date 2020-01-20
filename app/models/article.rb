class Article < ApplicationRecord
	belongs_to :user
	has_many :article_categories
	has_many :categories, through: :article_categories
	validates :title, presence: true, length: { minimum: 3, maximum: 50 } #  presence: true To ensure there is a tile, length defines the length
	validates :description, presence: true, length: { minimum: 10, maximum: 300 } # To ensure there is a tile
	validates :user_id, presence: true
end