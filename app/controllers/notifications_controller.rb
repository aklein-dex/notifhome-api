class NotificationsController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]

  def index
      @notifications = Notification.all()
      render json: @notifications
  end
  
  def create
      notification = Notification.create(
          message: params[:message],
          user: @current_user
          )
      render json: { notification: notification }
  end

end
