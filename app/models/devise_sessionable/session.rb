module DeviseSessionable
  class Session < ApplicationRecord
    acts_as_token_authenticatable

    belongs_to :authable, polymorphic: true, touch: true
  end
end
