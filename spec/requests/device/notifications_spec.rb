require 'rails_helper'

RSpec.describe 'Device Notifications API', type: :request do

  let(:user) { create(:user) }
  let(:device) { create(:device) }
  let(:token) { device.token }
  
  describe 'GET /device/notifications' do
    context 'when the request is valid' do
    
      let!(:notifications) { create_list(:notification, 10, user: user, device: device, created_at: DateTime.parse(2.weeks.since.to_s).to_time.strftime("%F %T")) }
      let!(:past_notifications) { create_list(:notification, 3, user: user, device: device, created_at: DateTime.parse(2.weeks.ago.to_s).to_time.strftime("%F %T")) }
  
      it 'returns all the new notifications' do
        get '/device/notifications', params: {}, headers: {"access-token": token}
        expect(response_json.size).to eq(10)
        expect(response_json[0]['device_id']).to eq(device.id)
        expect(response).to have_http_status(:ok)
      end
    end
    
    context 'when the request is invalid' do
      it 'doesnt get notifications if device is not authenticated' do
        get '/device/notifications'
        expect(response).to have_http_status(:unauthorized)
      end
    end
  
  end
  
end
