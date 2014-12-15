class Profile
  include ActiveModel::Model
  attr_accessor :id, :name, :email, :tagline, :avatar, :avatar_id
  
  def persisted?
    self.id.present?
  end
end
