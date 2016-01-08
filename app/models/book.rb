class Book < ActiveRecord::Base
	validates :isbn, presence: true, uniqueness: true
	validates :title, length: {minimum: 1, muximum: 100}
	validates :price, numericality: {only_integer: true}
end
