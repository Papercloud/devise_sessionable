require 'rails_helper'

module DeviseSessionable
  RSpec.describe Session, type: :model do
    it { is_expected.to belong_to(:authable) }
    it { is_expected.to validate_presence_of(:authable) }

    describe 'Simple token auth' do
      it 'sets the authentication_token automatically' do
        session = build(:session, authentication_token: nil)

        expect do
          session.save
        end.to change(session, :authentication_token).from nil
      end
    end
  end
end
