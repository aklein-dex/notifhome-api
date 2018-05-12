class DevicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_device, only: [:show, :update, :destroy]
  
  def index
    @devices = Device.all
    render json: {"devices": @devices}, status: :ok
  end
  
  def show
    render json: {"device": @device}, status: :ok
  end
  
  def update
    @device.assign_attributes(device_params)
    
    if params[:renew_token]
      @device.token = Device.generate_token
    end
    
    @device.save!
    render json: {"device": @device}, status: :ok
  end
  
  # So far, we allow just 1 device to be created.
  def create
    @device = Device.first
    if @device == nil
      @device = Device.new(device_params)
      @device.save!
    end
    render json: {"device": @device}, status: :created
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
    params.permit(:name)
  end
  
end
