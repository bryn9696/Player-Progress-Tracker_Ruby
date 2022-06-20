require 'teams'

describe MyTeams do

  it 'Adds team details into the myteams table' do
    MyTeams.create_team(team_name: 'Another Team',number_of_players: '1',coach_or_manager: 'bryn')
    connection = PG.connect(dbname: 'player_progress_tracker_test')
    result = connection.exec('SELECT * FROM my_teams')
    expect(result.map {|teams| p teams['team_name'] }).to include('Another Team')
    expect(result.map {|teams| p teams['number_of_players'] }).to eq(['1'])
    expect(result.map {|teams| p teams['coach_or_manager'] }).to eq(['bryn'])
  end

  it 'can check if a user team is unique' do 
    MyTeams.create_team(team_name: 'Another Team',number_of_players: '1',coach_or_manager: 'bryn')
    connection = PG.connect(dbname: 'player_progress_tracker_test')
    result = connection.exec('SELECT * FROM my_teams')
    expect(MyTeams.exist?(team_name: 'Another Team')).to eq true 
  end

  it '.view_team' do
    MyTeams.create_team(team_name: 'Another Team',number_of_players: '1',coach_or_manager: 'bryn')
    DatabaseConnection.query('SELECT * FROM my_teams')
    expect(MyTeams.view_teams[0]['team_name']).to eq('Another Team')
    expect(MyTeams.view_teams[0]['id']).to eq('1')
  end
  
end