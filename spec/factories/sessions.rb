FactoryGirl.define do
  factory :session, class: 'DeviseSessionable::Session' do
    association :authable, factory: :user
  end
end
