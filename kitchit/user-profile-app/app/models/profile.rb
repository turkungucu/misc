class Profile
  include ActiveModel::Model
  attr_accessor :id, :name, :email, :tagline, :avatar, :avatar_url
  
  def persisted?
    self.id.present?
  end
end
