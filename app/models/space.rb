class Space < ActiveRecord::Base

  belongs_to :user

  validates :square_meters, presence: true, numericality: {only_float: true, greater_than_or_equal_to: 0.5}
  validates :outdoors, inclusion: { in: [true, false] }
  validates :street_address, presence: true
  validates :province, presence: true
  validates :postal_code, presence: true
  validates :country, presence: true
  validates :city, presence: true

  after_create :round_square_meters


  private

  def round_square_meters
    self.square_meters = self.square_meters.round(1)
    self.save
  end

end
