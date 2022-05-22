require './lib/database_connection'

class Updater

  def self.list(id:)
    result = DatabaseConnection.query("SELECT * FROM my_teams WHERE user_id = $1;", [id])

    result.map do |team|
      team['team_name']
    end
  end

  def self.team_id(team:)
    result = DatabaseConnection.query("SELECT * FROM my_teams WHERE name = $1;", [team_name])
    result.map do |team|
      p team['id']
    end
  end

   def self.confirm_user(team_id:, user_id:)
    result = DatabaseConnection.query("SELECT * FROM my_teams WHERE id = $1 AND user_id = $2;", [team_id, user_id])
    result.count == 0 ? false : true
  end 

  def self.team_name(id)
    result = DatabaseConnection.query("SELECT * FROM my_teams WHERE id = $1;", [id])
    result.map do |team|
      p team['team_name']
    end
  end

end