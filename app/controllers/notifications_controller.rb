class NotificationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @notifications = Notification.all()
    render json: {"notifications": @notifications}, status: :ok
  end
  
  def create
    # save! will raise an exception if notification is not valid.
    # The exception is then catched by the concern ExceptionHandler (included in ApplicationController)
    @notification = Notification.new(notification_params)
    @notification.user = @current_user
    @notification.save!
    render json: {"notification": @notification}, status: :created
  end
  

  private
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def notification_params
    params.permit(:message)
  end
  
end
