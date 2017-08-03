class DeviseSessionableCreateSessions < ActiveRecord::Migration
  def change
    create_table :devise_sessionable_sessions do |t|
      t.string :authentication_token
      t.uuid :authable_id, null: false
      t.string :authable_type, null: false

      t.timestamps
    end

    add_index :devise_sessionable_sessions, [:authable_id, :authable_type]
    add_index :devise_sessionable_sessions, :authentication_token, unique: true
  end
end