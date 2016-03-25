class Space < ActiveRecord::Base

  belongs_to :user

  validates :square_meters, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 0.5}
  validates :unit_number, presence: true
  validates :street_address, presence: true
  validates :province, presence: true
  validates :postal_code, presence: true
  validates :country, presence: true
  validates :city, presence: true


end