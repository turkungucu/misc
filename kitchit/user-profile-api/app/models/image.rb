class Image < ActiveRecord::Base
  belongs_to :profile
  
  # Paperclip helper method that associates :avatar attr with a file attachment
  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  # Validate the attached file is an image
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  before_create :generate_public_id
  
  private
  
  # Generate a unique base 36 value
  def generate_public_id
    self.public_id = Time.now.to_i.to_s 36
  end
end
