SimpleTokenAuthentication::ExceptionFallbackHandler.module_eval do
  def fallback!(controller, entity)
    return unless controller.send(:current_authable).nil?

    throw(:warden, scope: entity.name_underscore.to_sym)
  end
end

# Overrides
SimpleTokenAuthentication::TokenAuthenticationHandler.module_eval do
  # All the token authentication actually happens on the session object,
  # However we want to `sign_in!` method to be passed the user.
  # So we override it here.
  def authenticate_entity_from_token!(entity)
    record = find_record_from_identifier(entity)

    return unless token_correct?(record, entity, token_comparator)
    perform_sign_in!(record.authable, sign_in_handler)
  end

  def find_record_from_identifier(entity)
    identifier_param_value = entity.get_identifier_from_params_or_headers(self)
                                   .presence

    # The finder method should be compatible with all the model adapters,
    # namely ActiveRecord and Mongoid in all their supported versions.
    identifier_param_value && entity.model.find_by(
      entity.identifier => identifier_param_value
    )
  end
end
