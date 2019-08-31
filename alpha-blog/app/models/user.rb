class User < ActiveRecord::Base

  has_many :articles #user is the one side of the one to many, article is plural because it is the many side 
  before_save { self.email = email.downcase }

  validates :username, presence: true,
  uniqueness: { case_sensitive: false },
  length: { minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 105 },
  uniqueness: { case_sensitive: false },
  format: { with: VALID_EMAIL_REGEX }
end