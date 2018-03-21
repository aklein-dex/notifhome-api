
module RequestSpecHelper
  # Parse JSON response to ruby hash
  def response_json
    JSON.parse(response.body)
  end
  
  def get_headers_for_next_requests
    { 'access-token': response.headers['access-token'], client: response.headers['client'], expiry: response.headers['expiry'], uid: response.headers['uid']}
  end
end
