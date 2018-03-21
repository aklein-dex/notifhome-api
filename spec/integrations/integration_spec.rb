require 'rails_helper'

RSpec.describe 'Integration tests', type: :request do

  describe 'Everything' do
    
    context 'when it should work as expected' do
      it 'get the notification' do
        password = 'secret123'
        email = 'test@test.com'
        
        # Sign up
        post '/auth', params: { email: email, password: password }
        
        # Requests are executed quickly, so it is considered as "batch requests".
        # In "batch requests", the token-access doesn't change.
        batch_headers = get_headers_for_next_requests
        
        # Create a device
        post '/devices', params: { device: { name: 'Omega2' } }, headers: batch_headers
        device_id    = response_json['id']
        device_token = response_json['token']
        expect(response_json['name']).to eq('Omega2')
        expect(response).to have_http_status(:created)
        
        # Create a notification
        post '/notifications', params: { notification: { message: 'Learn Elm', device_id: device_id } }, headers: batch_headers
        expect(response_json['message']).to eq('Learn Elm')
        expect(response).to have_http_status(:created)
        
        # Device receives the notification
        get '/device/notifications', params: {}, headers: {"access-token": device_token}
        expect(response_json.size).to eq(1)
        expect(response).to have_http_status(:ok)
      end
    end
    
  end
  
 
end
