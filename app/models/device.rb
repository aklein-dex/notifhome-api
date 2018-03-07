require 'bcrypt'

class Device < ApplicationRecord
  has_many :notifications
  
  validates_presence_of :name, :token, :last_request_at
  
  def self.generate_token
    token = SecureRandom.urlsafe_base64(nil, false)
    BCrypt::Password.create(token)
  end
end
