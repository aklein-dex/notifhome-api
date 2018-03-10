class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :device
  
  validates_presence_of :message, :device, :user
  
  scope :created_after, ->(time) { where("created_at > ?", time) }
end
