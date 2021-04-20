class User < ActiveRecord::Base
  has_many :authorizations, :dependent => :destroy
  validates :name, :email, :presence => true
  validate :staff_or_student
  def staff_or_student
    errors.add(:email, "must have SUNY ID") if
      email.split('@')[1] != "binghamton.edu"
  end
  
  
  def self.create_with_omniauth info
    create! do |user|
      user.name = info["name"]
      user.email = info["email"]
    end
  end
end