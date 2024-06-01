-- Comando SQL para definir qual base de dados iremos utilizar
USE nba_stats;

-- Qual é a média de pontos por jogo para cada jogador e qual jogador tem a maior média de pontos por jogo?
SELECT 
P.player_name,
P.player_position,
P.team,
P.games_played,
ROUND(SUM(S.points) / SUM(P.games_played), 1) AS 'Points_Per_Game' -- Comando ROUND() para arredondar o valor na saída
FROM players P
INNER JOIN stats S
ON P.id_player = S.id_player AND
S.player_position = P.player_position AND
S.ranked = P.ranked AND
S.player_name = P.player_name AND
S.age = P.age AND
S.team = P.team
WHERE P.games_played >= 58 -- A consulta retornará somente os jogadores que jogaram 58 ou mais jogos.
GROUP BY P.player_name, P.player_position, P.team, P.games_played
ORDER BY Points_Per_Game DESC -- Ordenando a aparição dos dados baseado na pontuação por jogo do maior ao menor (decrescente)
LIMIT 15; -- Limitando para aparecer somente 15 linhas



-- Qual jogador tem a melhor eficiência em termos de pontos por arremesso?
SELECT 
P.player_name,
P.player_position,
P.team,
S.field_goal,
S.two_points,
S.three_points,
ROUND((SUM(S.field_goal) + (0.5 * SUM(S.three_points))) / SUM(S.field_goal_attempts) * 100, 1) AS 'Effective_Field_Goal_Percent',
ROUND(SUM(S.two_points) / SUM(S.field_goal) * 100, 1) AS 'two_points_per_FG',
ROUND(SUM(S.three_points) / SUM(S.field_goal) * 100, 1) AS 'three_points_per_FG'
FROM players P
INNER JOIN stats S
ON P.id_player = S.id_player AND
S.player_position = P.player_position AND
S.ranked = P.ranked AND
S.player_name = P.player_name AND
S.age = P.age AND
S.team = P.team
WHERE S.field_goal >= 300 AND P.games_played >= 58 -- A consulta retornará somente os jogadores que acertaram 300 ou mais arremessos de quadra
-- e que jogaram 58 ou mais jogos.
GROUP BY P.player_name, P.player_position, P.team, S.field_goal, S.two_points, S.three_points
ORDER BY Effective_Field_Goal_Percent DESC
LIMIT 15;



-- Quais são as principais diferenças nas estatísticas médias entre jogadores das diferentes posições?
SELECT 
P.player_position,
COUNT(P.player_position) AS 'position_counting',
ROUND(SUM(S.points) / COUNT(P.player_position), 1) AS 'points_per_position',
ROUND(SUM(S.assists) / COUNT(P.player_position), 1) AS 'assists_per_position',
ROUND(SUM(S.field_goal) / SUM(S.field_goal_attempts) * 100, 1) AS 'field_goal_percent',
ROUND(SUM(S.three_points) / SUM(S.three_points_attempts) * 100, 1) AS 'three_points_percent',
ROUND(SUM(S.free_throws) / SUM(S.free_throws_attempts) * 100, 1) AS 'free_throws_percent'
FROM players P
INNER JOIN stats S
ON P.id_player = S.id_player AND
P.id_player = S.id_player AND
P.ranked = S.ranked AND
P.player_name = S.player_name AND
P.age = S.age AND
P.team = S.team
GROUP BY P.player_position
ORDER BY points_per_position DESC;



-- Qual é a taxa de sucesso dos jogadores em lances livres e quais jogadores têm as melhores taxas?
SELECT
P.player_name,
P.team,
S.free_throws,
S.free_throws_attempts,
ROUND(SUM(S.free_throws) / SUM(S.free_throws_attempts) * 100, 1) AS 'free_throw_percent'
FROM players P
INNER JOIN stats S
ON P.id_player = S.id_player
WHERE S.free_throws >= 125 -- A consulta retornará somente os jogadores que acertaram 125 ou mais lances livres.
GROUP BY P.player_name, P.team, S.free_throws, S.free_throws_attempts
ORDER BY free_throw_percent DESC;



-- Qual time tem a maior média de assistências por jogo?
SELECT 
S.team,
ROUND(SUM(S.assists) / 82, 1) AS 'assists_per_game'
FROM stats S
INNER JOIN players P
ON S.id_player = P.id_player AND
S.player_position = P.player_position AND
S.ranked = P.ranked AND
S.player_name = P.player_name AND
S.age = P.age AND
S.team = P.team
GROUP BY S.team
ORDER BY assists_per_game DESC;



-- Quais são as estatísticas principais dos jogadores da equipe que mais venceu jogos na temporada regular? (Boston Celtics)
SELECT 
P.player_name,
P.player_position,
P.team,
ROUND(SUM(S.points) / SUM(P.games_played), 1) AS 'points_per_game',
ROUND(SUM(S.assists) / SUM(P.games_played), 1) AS 'assists_per_game',
ROUND(SUM(S.blocks) / SUM(P.games_played), 1) AS 'blocks_per_game',
ROUND(SUM(S.steals) / SUM(P.games_played), 1) AS 'steals_per_game',
ROUND(SUM(S.field_goal) / SUM(S.field_goal_attempts) * 100, 1) AS 'field_goal_percent',
ROUND(SUM(S.three_points) / SUM(S.three_points_attempts) * 100, 1) AS 'three_points_percent',
ROUND(SUM(S.free_throws) / SUM(S.free_throws_attempts) * 100, 1) AS 'free_throw_percent'
FROM players P
INNER JOIN stats S
ON S.id_player = P.id_player AND
S.player_position = P.player_position AND
S.ranked = P.ranked AND
S.player_name = P.player_name AND
S.age = P.age AND
S.team = P.team
WHERE P.team = 'Boston Celtics' -- A consulta retornará somente os jogadores que jogaram pelo Boston Celtics.
GROUP BY P.player_name, P.team, P.player_position
ORDER BY points_per_game DESC;



-- E da equipe que mais perdeu jogos na temporada regular (Detroit Pistons)?
SELECT 
P.player_name,
P.player_position,
P.team,
ROUND(SUM(S.points) / SUM(P.games_played), 1) AS 'points_per_game',
ROUND(SUM(S.assists) / SUM(P.games_played), 1) AS 'assists_per_game',
ROUND(SUM(S.blocks) / SUM(P.games_played), 1) AS 'blocks_per_game',
ROUND(SUM(S.steals) / SUM(P.games_played), 1) AS 'steals_per_game',
ROUND(SUM(S.field_goal) / SUM(S.field_goal_attempts) * 100, 1) AS 'field_goal_percent',
ROUND(SUM(S.three_points) / SUM(S.three_points_attempts) * 100, 1) AS 'three_points_percent',
ROUND(SUM(S.free_throws) / SUM(S.free_throws_attempts) * 100, 1) AS 'free_throw_percent'
FROM players P
INNER JOIN stats S
ON S.id_player = P.id_player AND
S.player_position = P.player_position AND
S.ranked = P.ranked AND
S.player_name = P.player_name AND
S.age = P.age AND
S.team = P.team
WHERE P.team = 'Detroit Pistons' -- A consulta retornará somente os jogadores que jogaram pelo Detroit Pistons.
GROUP BY P.player_name, P.team, P.player_position
ORDER BY points_per_game DESC;
