# frozen_string_literal: true

require './lib/database_connection'

if ENV['ENVIRONMENT'] == 'test'
  DatabaseConnection.setup('player_progress_tracker_test')

  DatabaseConnection.query("ALTER SEQUENCE users_id_seq RESTART WITH 1;")
  DatabaseConnection.query("ALTER SEQUENCE players_id_seq RESTART WITH 1;")
  DatabaseConnection.query("ALTER SEQUENCE my_teams_id_seq RESTART WITH 1;")
  DatabaseConnection.query("ALTER SEQUENCE teams_id_seq RESTART WITH 1;")
  # DatabaseConnection.query("ALTER SEQUENCE bookings_id_seq RESTART WITH 1;")
else
  DatabaseConnection.setup('player_progress_tracker')
end