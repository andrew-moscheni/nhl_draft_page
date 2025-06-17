CREATE DATABASE nhl_draft_page;

CREATE TYPE s_type AS ENUM ('draft', 'regular', 'playoffs');

--player table
CREATE TABLE player(
    player_id SERIAL PRIMARY KEY,
    name VARCHAR(200),
    current_team VARCHAR(200),
    position VARCHAR(1),
    birth_date VARCHAR(10),
);

--player stats for a specified season (could be draft, regular season, or playoffs)
CREATE TABLE player_season_stats(
    draft_stats_id SERIAL PRIMARY KEY,
    season_type s_type, 
    player_id INTEGER NOT NULL,
    year INTEGER NOT NULL,
    pick INTEGER NOT NULL,
    last_year INTEGER NOT NULL,
    amateur_league VARCHAR(200),
    
    --performance measures
    goals INTEGER DEFAULT 0,
    assists INTEGER DEFAULT 0,
    games_played INTEGER DEFAULT 0,
    points INTEGER GENERATED ALWAYS AS (goals + assists) STORED,
    plus_minus INTEGER DEFAULT 0,
    penalty_minutes INTEGER DEFAULT 0,

    --playoff performance measures
    po_goals INTEGER DEFAULT 0,
    po_assists INTEGER DEFAULT 0,
    po_games_played INTEGER DEFAULT 0,
    po_points INTEGER GENERATED ALWAYS AS (goals + assists) STORED,
    po_plus_minus INTEGER DEFAULT 0,
    po_penalty_minutes INTEGER DEFAULT 0,

    --constraints
    FOREIGN KEY (player_id) REFERENCES player(player_id) ON DELETE CASCADE,
    UNIQUE (player_id, season_year, team_name) 
);

/*sample usage for part of the structure
one season
SELECT
    p.name,
    p.position,
    pss.season_year,
    pss.team_name,
    pss.goals,
    pss.assists,
    pss.games_played,
    pss.points -- The generated column
FROM
    player p
JOIN
    player_season_stats pss ON p.player_id = pss.player_id
WHERE
    p.name = 'Connor McDavid' AND pss.season_year = 2024;

all seasons
SELECT
    p.name,
    pss.season_year,
    pss.team_name,
    pss.goals,
    pss.assists,
    pss.games_played,
    pss.points
FROM
    player p
JOIN
    player_season_stats pss ON p.player_id = pss.player_id
WHERE
    p.name = 'Auston Matthews'
ORDER BY
    pss.season_year DESC;
*/

-- store games as tables
CREATE TABLE game (
    game_id SERIAL PRIMARY KEY,
    game_date DATE NOT NULL,
    home_team VARCHAR(100) NOT NULL,
    away_team VARCHAR(100) NOT NULL,
    venue VARCHAR(100),

    home_score INTEGER,
    away_score INTEGER
);

CREATE TABLE player_game_log (
    game_log_id SERIAL PRIMARY KEY,
    player_id INTEGER NOT NULL,
    game_id INTEGER NOT NULL,
    
    goals INTEGER DEFAULT 0,
    assists INTEGER DEFAULT 0,
    points INTEGER GENERATED ALWAYS AS (goals + assists) STORED,
    pims INTEGER,
    plus_minus INTEGER DEFAULT 0,

    FOREIGN KEY (player_id) REFERENCES player(player_id),
    FOREIGN KEY (game_id) REFERENCES game(game_id),
    
    UNIQUE (player_id, game_id)
);

--predicted statlines
CREATE TABLE player_predicted_statline (
    prediction_id SERIAL PRIMARY KEY,
    player_id INTEGER NOT NULL,
    game_id INTEGER NOT NULL,
    prediction_date DATE NOT NULL DEFAULT CURRENT_DATE,
    
    predicted_goals DECIMAL(4,2),
    predicted_assists DECIMAL(4,2),
    predicted_points DECIMAL(4,2) GENERATED ALWAYS AS (predicted_goals + predicted_assists) STORED,
    predicted_plus_minus DECIMAL(4,2),
    predicted_pims DECIMAL(4,2),
    
    FOREIGN KEY (player_id) REFERENCES player(player_id),
    FOREIGN KEY (game_id) REFERENCES game(game_id),
    
    -- Ensure only one prediction per player per game
    UNIQUE (player_id, game_id)
);

CREATE TABLE team(
    team_id SERIAL PRIMARY KEY,
    name VARCHAR(),
    goals_for DECIMAL(10,2) NOT NULL,
    goals_against DECIMAL(10,2) NOT NULL
);