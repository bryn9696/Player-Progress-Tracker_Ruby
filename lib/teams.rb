require './lib/database_connection'

class Teams

  def self.create_player(name:, age:, email:, phone:)
    DatabaseConnection.query("INSERT INTO teams (name, age, email, phone) VALUES($1, $2, $3, $4) RETURNING name, age, email, phone;", [name, age, email, phone]
      )
  end

  # def self.exist?(team_name:)
  #   result = DatabaseConnection.query("SELECT * FROM my_teams WHERE team_name = $1;",[team_name] )
  #   @unsuccessful = !result.to_a.empty?
  # end 

  # def self.unsuccessful 
  #   @unsuccessful 
  # end

  # def self.view_teams
  #   result = DatabaseConnection.query("SELECT * FROM my_teams;")
  #   result.to_a
    
  #   #, RETURNING name, price, description;", [name, price, description])
  #   #result.map { |listing| listing['name']}
  # end

  # def self.view_team_details(id)
  #   result = DatabaseConnection.query("SELECT * FROM my_teams WHERE id = $1;",[id])
  #   result.to_a
  # end

  # def self.update_team(id:, team_name:, number_of_players:, coach_or_manger:)
  #   result = DatabaseConnection.query("UPDATE my_teams SET coach_or_manager = $4, number_of_players = $3, team_name = $2  WHERE id = $1 ", [id,team_name,number_of_players,coach_or_manager])
  # end
end