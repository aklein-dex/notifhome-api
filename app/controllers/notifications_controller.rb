class NotificationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @notifications = Notification.all()
    json_response @notifications
  end
  
  def create
    # create! will raise an exception if notification is not valid.
    # The exception is then catched by the concern ExceptionHandler (included in ApplicationController)
    @notification = Notification.create!(
      message: params[:message],
      user: @current_user,
      device_id: params[:device_id]
      )
    json_response @notification, :created
  end
  
  private
  # todo allow params

end
