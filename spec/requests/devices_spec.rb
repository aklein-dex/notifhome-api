require 'rails_helper'

RSpec.describe 'Devices API', type: :request do

  let(:user) { create(:user) }
  let(:device) { create(:device) }
  
  describe 'GET /devices' do
    
    let!(:devices) { create_list(:device, 10) }
  
    context 'when the request is valid' do
      it 'get all devices' do
        auth_headers = user.create_new_auth_token
        
        get '/devices', params: {}, headers: auth_headers
        expect(response_json.size).to eq(10)
        expect(response).to have_http_status(:ok)
      end
    end
    
    context 'when the request is invalid' do
      it 'doesnt get devices if user is not authenticated' do
        get '/devices'
        expect(response).to have_http_status(:unauthorized)
      end
    end
  
  end
  
  describe 'POST /devices' do
    
    let(:valid_attributes) { { device: { name: 'Omega2' } } }

    context 'when the request is valid' do
      it 'creates a device' do
        auth_headers = user.create_new_auth_token
        
        post '/devices', params: valid_attributes, headers: auth_headers
        expect(response_json['name']).to eq('Omega2')
        expect(response).to have_http_status(:created)
      end
    end
    
    context 'when the request is invalid' do
      it 'doesnt create a notification if user is not authenticated' do
        post '/devices', params: valid_attributes
        expect(response).to have_http_status(:unauthorized)
      end
      
      it 'doesnt create a device without name' do
        auth_headers = user.create_new_auth_token
        
        post '/devices', params: {}, headers: auth_headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
      
      
      it 'doesnt set the token' do
        auth_headers = user.create_new_auth_token
        
        params = { device: { name: 'Omega2', token: 'abcde' } }
        post '/devices', params: params, headers: auth_headers
        expect(response).to have_http_status(:created)
        expect(response_json['token']).not_to eq('abcde')
      end
    end
  end
  
  
  describe 'GET /devices/:id' do
   
    context 'when the device exists' do
      it 'returns a device' do
        auth_headers = user.create_new_auth_token
        
        get "/devices/#{device.id}", params: {}, headers: auth_headers
        expect(response_json).not_to be_empty
        expect(response_json['id']).to eq(device.id)
        expect(response).to have_http_status(:ok)
      end
    end
  
    context 'when the request is invalid' do
      it 'returns an error for non authenticaed users' do
        get "/devices/#{device.id}"
        expect(response).to have_http_status(:unauthorized)
      end
      
      it 'returns an empty response' do
        auth_headers = user.create_new_auth_token
        
        get '/devices/999', params: {}, headers: auth_headers
        expect(response_json['message']).to match(/Couldn't find Device/)
        expect(response).to have_http_status(:not_found)
      end

    end
  end
  
  describe 'PATCH /devices/:id' do
   
    context 'when the device exists' do
      it 'returns a device with a new token' do
        auth_headers = user.create_new_auth_token
        
        patch "/devices/#{device.id}", params: {renew_token: 1}, headers: auth_headers
        expect(response_json['token']).not_to be_empty 
        expect(response_json['token']).not_to eq(device.token)
        expect(response).to have_http_status(:ok)
      end
      
      it 'returns a device with a new name' do
        auth_headers = user.create_new_auth_token
        
        patch "/devices/#{device.id}", params: {device: {name: 'raspberry pi'}}, headers: auth_headers
        expect(response_json['name']).to eq('raspberry pi') 
        expect(response_json['token']).to eq(device.token)
        expect(response).to have_http_status(:ok)
      end
      
    end
    
    context 'when the request is invalid' do
      it 'returns an error for non authenticaed users' do
        patch "/devices/#{device.id}", params: {renew_token: 1}
        expect(response).to have_http_status(:unauthorized)
      end
      
      it 'returns an empty response' do
        auth_headers = user.create_new_auth_token
        
        patch '/devices/999', params: {renew_token: 1}, headers: auth_headers
        expect(response_json['message']).to match(/Couldn't find Device/)
        expect(response).to have_http_status(:not_found)
      end

    end
  end

  describe 'DELETE /devices/:id' do
   
    context 'when the device exists' do
      it 'deletes a device' do
        auth_headers = user.create_new_auth_token
        
        delete "/devices/#{device.id}", params: {}, headers: auth_headers
        expect(response.body).to be_empty
        expect(response).to have_http_status(:no_content)
      end
    end
    
    context 'when the request is invalid' do
      it 'returns an error for non authenticaed users' do
        delete "/devices/#{device.id}", params: {}
        expect(response).to have_http_status(:unauthorized)
      end
      
      it 'cant find a device' do
        auth_headers = user.create_new_auth_token
        
        delete '/devices/999', params: {}, headers: auth_headers
        expect(response_json['message']).to match(/Couldn't find Device/)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

end
