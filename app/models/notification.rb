class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :device
  
  validates_presence_of :message, :device, :user
end
