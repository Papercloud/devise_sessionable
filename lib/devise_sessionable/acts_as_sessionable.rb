module DeviseSessionable
  module ActsAsSessionable
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def acts_as_sessionable(_options = {})
        has_many :sessions,
                 as: :authable,
                 class_name: 'DeviseSessionable::Session'
      end
    end
  end
end
