require 'rails_helper'

RSpec.describe Notification, type: :model do
  it { should validate_presence_of(:message) }
  it { should belong_to(:user) }
  it { should belong_to(:device) }
end
