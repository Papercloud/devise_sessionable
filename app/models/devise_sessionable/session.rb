module DeviseSessionable
  class Session < ApplicationRecord
    belongs_to :authable, polymorphic: true, touch: true

    validates :authable, presence: true
  end
end
