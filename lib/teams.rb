require './lib/database_connection'

class MyTeams

  def self.create_team(team_name:, number_of_players:, coach_or_manager:, user_id:)
    DatabaseConnection.query("INSERT INTO my_teams (team_name, number_of_players, coach_or_manager, user_id) VALUES($1, $2, $3, $4) RETURNING team_name, number_of_players, coach_or_manager;", [team_name, number_of_players, coach_or_manager, user_id]
      )
  end

  def self.exist?(team_name:)
    result = DatabaseConnection.query("SELECT * FROM my_teams WHERE team_name = $1;",[team_name] )
    @unsuccessful = !result.to_a.empty?
  end 

  def self.unsuccessful 
    @unsuccessful 
  end

  def self.view_teams
    result = DatabaseConnection.query("SELECT * FROM my_teams;")
    result.to_a
    
    #, RETURNING name, price, description;", [name, price, description])
    #result.map { |listing| listing['name']}
  end

  def self.view_team_details(id)
    result = DatabaseConnection.query("SELECT * FROM my_teams WHERE id = $1;",[id])
    result.to_a
  end

  def self.update_team(id:, team_name:, number_of_players:, coach_or_manger:)
    result = DatabaseConnection.query("UPDATE my_teams SET coach_or_manager = $4, number_of_players = $3, team_name = $2  WHERE id = $1 ", [id,team_name,number_of_players,coach_or_manager])
  end
end