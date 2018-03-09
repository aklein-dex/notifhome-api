require 'bcrypt'

class Device < ApplicationRecord
  before_validation :set_token, on: :create
  before_validation :set_last_request_at, on: :create
  
  has_many :notifications
  
  validates_presence_of :name, :token, :last_request_at
  
  def set_token
    self.token = Device.generate_token
  end
  
  def set_last_request_at
    self.last_request_at = DateTime.now
  end
  
  def self.generate_token
    token = SecureRandom.urlsafe_base64(nil, false)
    BCrypt::Password.create(token)
  end
end
