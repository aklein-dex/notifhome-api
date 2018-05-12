class Device::NotificationsController < ApplicationController
  before_action :authenticate_device
  
  # Return the new notifications
  # update the last_request_at timestamp
  def index
    @notifications = Notification.created_after(@device.last_request_at)
    @device.set_last_request_at
    @device.save!
    render json: {"notifications": @notifications}, status: :ok
  end
  
  # todo: when the user press the button on the omega board (meaning he read the
  #       notification), it would be nice that the board send a request to the server
  #       so we can save in the db when the notification was read.
  
  private
  
  # Find the device based on the access-token
  def authenticate_device
    token = request.headers['access-token']
    @device = Device.find_by(token: token)
    
    # todo we could save the IP from where the request originated and make
    # sure the requests always come from the same IP.
    
    if @device == nil
      return render json: { error: "invalid token" }, status: :unauthorized
    end
  end

end
