class Client < ApplicationRecord
  has_many :users
  has_many :products, through: :categories
  has_many :categories
end
