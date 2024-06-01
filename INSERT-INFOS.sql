-- Criando o banco de dados onde ficará armazenada as tabelas e informações
CREATE DATABASE nba_stats;

-- Criando a tabela 'players' referente ao arquivo csv 'nba-stats-2023-players'
CREATE TABLE players
(id_player VARCHAR(60) NOT NULL,
ranked INT NOT NULL,
player_name VARCHAR(200) NOT NULL,
player_position VARCHAR(5) NOT NULL,
age INT NOT NULL,
team VARCHAR(150) NOT NULL,
games_played INT NOT NULL,
games_started INT NOT NULL,
minutes_played INT NOT NULL);

-- Criando a tabela 'stats' referente ao arquivo csv 'nba-stats-2023-points'
CREATE TABLE stats
(id_player VARCHAR(60) NOT NULL,
ranked INT NOT NULL,
player_name VARCHAR(200) NOT NULL,
player_position VARCHAR(5) NOT NULL,
age INT NOT NULL,
team VARCHAR(150) NOT NULL,
field_goal INT NOT NULL,
field_goal_attempts	INT NOT NULL,
three_points INT NOT NULL,
three_points_attempts INT NOT NULL,
two_points INT NOT NULL,	
two_points_attempts	INT NOT NULL,
free_throws INT NOT NULL,	
free_throws_attempts INT NOT NULL,
offensive_rebounds INT NOT NULL,
defensive_rebounds INT NOT NULL,	
total_rebounds INT NOT NULL,	
assists	INT NOT NULL,
steals INT NOT NULL,
blocks INT NOT NULL,
turnovers INT NOT NULL,
personal_fouls INT NOT NULL,
points INT NOT NULL);

-- Inserindo os dados do arquivo 'nba-stats-2023-players.csv' na tabela players do SQL
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/nba-stats-2023-players.csv'
INTO TABLE players
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; -- Ignorando a primeira linha do arquivo por se tratar do cabeçalho

-- Inserindo os dados do arquivo 'nba-stats-2023-points.csv' na tabela stats do SQL
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/nba-stats-2023-points.csv'
INTO TABLE stats
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; -- Ignorando a primeira linha do arquivo por se tratar do cabeçalho
