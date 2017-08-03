require 'rails_helper'

module DeviseSessionable
  RSpec.describe Session, type: :model do

    it { is_expected.to belong_to(:authable) }

    it { is_expected.to validate_presence_of(:authable) }
  end
end
