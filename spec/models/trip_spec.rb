require 'rails_helper'

RSpec.describe Trip, type: :model do
  it { should validate_presence_of :status }
end
