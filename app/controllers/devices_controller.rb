class DevicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_device, only: [:show, :update, :destroy]
  
  def index
    @devices = Device.all
    json_response @devices
  end
  
  def show
    json_response @device
  end
  
  def update
    @device.assign_attributes(device_params)
    
    if params[:renew_token]
      @device.token = Device.generate_token
    end
    
    @device.save!
    json_response @device
  end
  
  def create
    @device = Device.new(device_params)
    @device.save!
    json_response @device, :created
  end
  
  def destroy
    @device.destroy
    head :no_content
  end

  private
  
  def set_device
    @device = Device.find(params[:id])
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def device_params
    params.fetch(:device, {}).permit(:name)
  end
  
end
