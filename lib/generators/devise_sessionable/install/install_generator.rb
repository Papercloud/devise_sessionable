require 'rails/generators/active_record'

module DeviseSessionable
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    source_root File.expand_path('../templates', __FILE__)

    def copy_migration
      migration_template 'migration.rb',
                         'db/migrate/devise_sessionable_create_sessions.rb'
    end

    # Implement the required interface for Rails::Generators::Migration.
    def self.next_migration_number(dirname)
      next_migration_number = current_migration_number(dirname) + 1
      if ActiveRecord::Base.timestamped_migrations
        [Time.now.utc.strftime('%Y%m%d%H%M%S'), '%.14d' % next_migration_number].max
      else
        '%.3d' % next_migration_number
      end
    end
  end
end
