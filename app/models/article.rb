class Article < ApplicationRecord
	validates :title, presence: true, length: { minimum: 3, maximum: 50 } #  presence: true To ensure there is a tile, length defines the length
	validates :description, presence: true, length: { minimum: 10, maximum: 300 } # To ensure there is a tile

end