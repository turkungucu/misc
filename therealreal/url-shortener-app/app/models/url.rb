class Url < ActiveRecord::Base
  BASE_URL = 'http://aqueous-brook-6980.herokuapp.com/'
  
  before_validation :ensure_protocol
  before_save :generate_key
  
  validates :long_url, presence: true, url: true
  
  def short_url
    BASE_URL + key
  end
  
  private
  
  def generate_key
    self.key = Time.now.to_i.to_s 36
  end
  
  def ensure_protocol
    unless long_url.match(/^(http|https):\/\/.*/)
      long_url.prepend('http://')
    end
  end
end
