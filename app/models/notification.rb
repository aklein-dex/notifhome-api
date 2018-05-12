class Notification < ApplicationRecord
  belongs_to :user
  
  validates_presence_of :message, :user
  
  scope :created_after, ->(time) { where("created_at > ?", time) }
end
