class Profile < ActiveRecord::Base
  has_one :image
  
  validates :name, presence: true
  validates :email, presence: true
  validates :tagline, presence: true
  
  before_create :generate_public_id
  
  private
  
  # Generate a unique base 36 value
  def generate_public_id
    self.public_id = Time.now.to_i.to_s 36
  end
end
