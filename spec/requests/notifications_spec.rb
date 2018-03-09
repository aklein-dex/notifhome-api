require 'rails_helper'

RSpec.describe 'Notifications API', type: :request do

  let(:user) { create(:user) }
  let(:device) { create(:device) }
  
  describe 'POST /notifications' do
    
    let(:valid_attributes) { { notification: { message: 'Learn Elm', device_id: device.id } } }

    context 'when the request is valid' do
      it 'creates a notification' do
        auth_headers = user.create_new_auth_token
        
        post '/notifications', params: valid_attributes, headers: auth_headers
        expect(response_json['message']).to eq('Learn Elm')
        expect(response).to have_http_status(:created)
      end
    end
    
    context 'when the request is invalid' do
      it 'doesnt create a notification if user is not authenticated' do
        post '/notifications', params: valid_attributes
        expect(response).to have_http_status(:unauthorized)
      end
      
      it 'doesnt create a notification if attributes are not valid' do
        auth_headers = user.create_new_auth_token
        
        no_message = { notification: { device_id: device.id } }
        post '/notifications', params: no_message, headers: auth_headers
        expect(response).to have_http_status(:unprocessable_entity)
        
        no_device = { notification: {message: 'Learn Elm' } }
        post '/notifications', params: no_device, headers: auth_headers
        expect(response).to have_http_status(:unprocessable_entity)
        
        # for device_id I could get the id of the last notification and add 1.
        wrong_device_id = { notification: {message: 'Learn Elm', device_id: 999 } }
        post '/notifications', params: wrong_device_id, headers: auth_headers
        expect(response).to have_http_status(:unprocessable_entity)
        
      end
    
    end
  end
  
  describe 'GET /notifications' do
    context 'when the request is valid' do
    
      let!(:notifications) { create_list(:notification, 10, user: user, device: device) }
  
      it 'returns all the notifications' do
        
        auth_headers = user.create_new_auth_token
        get '/notifications', params: {}, headers: auth_headers
        expect(response_json.size).to eq(10)
        expect(response).to have_http_status(:ok)
      end
    end
    
    context 'when the request is invalid' do
      it 'doesnt get notifications if user is not authenticated' do
        get '/notifications'
        expect(response).to have_http_status(:unauthorized)
      end
    end
  
  end
  
end
