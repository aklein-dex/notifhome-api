require 'rails_helper'


RSpec.describe Device, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:token) }
  it { should validate_presence_of(:last_request_at) }
  
  it { should have_many(:notifications) }
end
