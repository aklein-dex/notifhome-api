class AddDeviceToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_reference :notifications, :device, foreign_key: true
  end
end
