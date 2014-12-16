class Profile
  include ActiveModel::Model
  extend ActiveModel::Naming
  
  attr_accessor :id, :name, :email, :tagline, :avatar, :avatar_id, :errors
  
  def initialize(attributes={})
    super
    @errors = ActiveModel::Errors.new(self)
  end
  
  def persisted?
    self.id.present?
  end
end
