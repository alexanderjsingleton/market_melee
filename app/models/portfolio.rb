class Portfolio < ActiveRecord::Base
  has_many :stocks
  belongs_to :user

  validates :name, length: { minimum: 2 }, presence: true
end
