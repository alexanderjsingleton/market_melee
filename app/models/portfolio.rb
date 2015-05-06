class Portfolio < ActiveRecord::Base
  has_many :stocks
  belongs_to :user

  validates_format_of :url, :with => URI::regexp(%w(http https))
  validates :name, length: { minimum: 2 }, presence: true
end
