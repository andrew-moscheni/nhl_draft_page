CREATE DATABASE nhl_draft_page;

--drop if table/type exists
DROP TABLE IF EXISTS player, team CASCADE;
DROP TYPE IF EXISTS s_type CASCADE;
DROP TYPE IF EXISTS player_season_stat_entry, player_game_log, player_predicted_statline CASCADE;

CREATE TYPE s_type AS ENUM ('draft', 'regular', 'playoffs');

--player stats for a specified season (could be draft year, regular season, or playoffs)
CREATE TYPE player_season_stats_entry AS (
    --season info
    season_type s_type, 
    season_year INTEGER NOT NULL,
    
    --performance measures
    goals INTEGER DEFAULT 0,
    assists INTEGER DEFAULT 0,
    games_played INTEGER DEFAULT 0,
    points INTEGER GENERATED ALWAYS AS (goals + assists) STORED,
    plus_minus INTEGER DEFAULT 0,
    penalty_minutes INTEGER DEFAULT 0
);

--game logs
CREATE TYPE player_game_log AS (
    game_date DATE NOT NULL,
    goals INTEGER DEFAULT 0,
    assists INTEGER DEFAULT 0,
    points INTEGER GENERATED ALWAYS AS (goals + assists) STORED,
    pims INTEGER,
    plus_minus INTEGER DEFAULT 0
);

--predicted statlines
CREATE TYPE player_predicted_statline AS (
    prediction_date DATE DEFAULT CURRENT_DATE,
    predicted_goals DECIMAL(4,2),
    predicted_assists DECIMAL(4,2),
    predicted_points DECIMAL(4,2) GENERATED ALWAYS AS (predicted_goals + predicted_assists) STORED,
    predicted_plus_minus DECIMAL(4,2),
    predicted_pims DECIMAL(4,2)
);

--player table
CREATE TABLE player(
    player_id SERIAL PRIMARY KEY,
    name VARCHAR(200),
    current_team VARCHAR(200),
    position VARCHAR(1),
    birth_date VARCHAR(10),
    pick INTEGER NOT NULL,
    last_year INTEGER NOT NULL,
    amateur_league VARCHAR(200),
    retired BOOLEAN,

    --season statistics
    season_stats player_season_stat_entry[] DEFAULT ARRAY[]::player_season_stat_entry[],

    --game log storage
    game_logs player_game_log[] DEFAULT ARRAY[]::player_game_log[],

    --predicted statline storage
    predicted_stats player_predicted_statline[] DEFAULT ARRAY[]:player_predicted_statline[],

    --totals
    all_time_totals player_predicted_statline
);

CREATE TYPE team_season_stat AS (
    season INTEGER NOT NULL,
    goals_for DECIMAL(10,2) NOT NULL,
    goals_against DECIMAL(10,2) NOT NULL
)

--team storage for external predictors for ACP
CREATE TABLE team(
    team_id SERIAL PRIMARY KEY,
    name VARCHAR(),
    team_stats team_season_stat[] DEFAULT ARRAY[]::team_season_stat[]
);