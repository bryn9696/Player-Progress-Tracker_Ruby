require 'teams'

describe MyTeams do

  it 'Adds team details into the myteams table' do
    MyTeams.create_team(team_name: 'Another Team',number_of_players: '1',coach_or_manager: 'bryn', my_teams_id: 1, user_id:  1)
    connection = PG.connect(dbname: 'player_progress_tracker_test')
    result = connection.exec('SELECT * FROM my_teams')
    expect(result.map {|teams| p teams['team_name'] }).to include('Another Team')
  end

  it 'can check if a user team is unique' do 
    MyTeams.create_team(team_name: 'Another Team',number_of_players: '1',coach_or_manager: 'bryn', my_teams_id: 1, user_id: 1)
    connection = PG.connect(dbname: 'player_progress_tracker_test')
    result = connection.exec('SELECT * FROM my_teams')
    expect(MyTeams.exist?(team_name: 'Another Team')).to eq true 
  end

#   it '.view_team' do
#     MyTeams.create_team(team_name: 'Another Team',number_of_players: '1',coach_or_manager: 'bryn', my_teams_id: 1, user_id: 1)
#     DatabaseConnection.query('SELECT * FROM my_teams')
#     expect(MyTeams.view_teams[0]['name']).to eq('Another Team')
#     expect(MyTeams.view_teams[0]['id']).to eq('1')
#   end
  
end