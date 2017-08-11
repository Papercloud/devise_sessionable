require 'simple_token_authentication'
require "devise_sessionable/engine"

module DeviseSessionable
  extend ActiveSupport::Autoload

  autoload :ActsAsSessionable, 'devise_sessionable/acts_as_sessionable'
end

module ActiveRecord
  class Base
    include DeviseSessionable::ActsAsSessionable
  end
end

