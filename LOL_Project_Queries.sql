-- #1
-- As part of the monthly game balancing review, the Riot balance team wants to understand which champions are performing extraordinarily well in the current patch. 
-- List the champions by the descending order of win rates. 

select c.key as champion_id, c.name, round((a.winner_count) / a.total_count, 4) as winrate
from (select mp.championId,
sum(case when wd.teamid = mp.teamid then 1 else 0 end) as winner_count, count(*) as total_count
from matchparticipants mp left join winnerdata wd
on wd.gameId_winner = mp.gameId
group by mp.championId) a
inner join champion c on c.key = a.championId
order by (a.winner_count) / a.total_count desc;

-- #2
-- It is almost a consensus that being able to pilot a large quantity of champions (aka having a decently large “champion pool”) can increase a player’s win rate, 
-- as they can adapt to more difficult situations, such as their main champ getting banned, or that their main champs are not very strong in the current meta. 
-- Now, categorize player by the following rules: for players that played a total of 1-5 champs in all their recorded games in this DB, label them “Champion Spoon”; 
-- for players that played a total of 6-20 champs, label them “Champion Pool”; anymore than that, label them “Champion Sea”. Return all players’ account IDs, summoner names, number of chamions played, along with their champion pool size labels. 

select pa.accountid, pa.summonername, count(distinct mp.championid) as championsplayed,
case
when count(distinct mp.championid) between 1 and 5 then 'champion spoon'
when count(distinct mp.championid) between 6 and 20 then 'champion pool'
when count(distinct mp.championid) > 20 then 'champion sea'
end as championpoollabel
from playeraccounts pa inner join matchparticipants mp 
on pa.accountid = mp.accountid
group by pa.accountid, pa.summonername;

-- #3
-- Now, determine if players with a larger champion tool have higher win rate. Select the top 20 high-win-rate players from each champion pool category and compare their win rates in a table. 

with player_win_rate as (
select pa.accountid, pa.summonername, count(distinct mp.championid) as unique_champs,
case
when count(distinct mp.championid) between 1 and 5 then 'champion spoon'
when count(distinct mp.championid) between 6 and 20 then 'champion pool'
when count(distinct mp.championid) > 20 then 'champion sea'
end as championpoollabel,
sum(case when mp.teamid = wd.teamid then 1 else 0 end) / count(mp.gameid) as win_rate
from playeraccounts pa inner join matchparticipants mp 
on pa.accountid = mp.accountid inner join winnerdata wd 
on mp.gameid = wd.gameid_winner
group by pa.accountid, pa.summonername
having sum(case when mp.teamid = wd.teamid then 1 else 0 end) / count(mp.gameid) < 1),
ranked_players as (
select accountid, summonername, championpoollabel, win_rate,
row_number() over (partition by championpoollabel order by win_rate desc) as ranking
from player_win_rate)
select accountid, summonername, championpoollabel, win_rate
from ranked_players
where ranking <= 20
order by championpoollabel, win_rate desc;


-- #4
-- Survivability stats are a core component to a champion's power level. List the champions and their tags, by their innate survivability stats at level 6 in descending order. 
-- Survivability stats include hp, armor, spellblock, hpregen, and move speed. The total of survivability can simply be the additional of all these stats. 

select id, tags, (hp + hpperlevel*6 + armor + armorperlevel*6 + spellblock + spellblockperlevel*6 + hpregen + hpregenperlevel*6 + movespeed) as survivability
from champion 
order by (hp + 18*hpperlevel) desc;

-- #5
-- Find the 5 richest players in all games played - meaning the one who bought the most expensive item combination. List their accountId, summoner name, names of all purchased items and the total price. 

select pa.accountid, pa.summonername, c.name as champion_name,
i0.name item0_name, i1.name item1_name, i2.name item2_name,
i3.name item3_name, i4.name item4_name, i5.name item5_name,
coalesce(i0.buyprice, 0) + coalesce(i1.buyprice, 0) + coalesce(i2.buyprice, 0) +
coalesce(i3.buyprice, 0) + coalesce(i4.buyprice, 0) + coalesce(i5.buyprice, 0) as total_item_cost
from playeraccounts pa inner join matchparticipants mp 
on pa.accountid = mp.accountid inner join champion c
on mp.championId =  c.key left join item i0 
on mp.item0 = i0.itemid left join item i1 
on mp.item1 = i1.itemid left join item i2 
on mp.item2 = i2.itemid left join item i3
on mp.item3 = i3.itemid left join item i4 
on mp.item4 = i4.itemid left join item i5 
on mp.item5 = i5.itemid
order by 
coalesce(i0.buyprice, 0) + coalesce(i1.buyprice, 0) + coalesce(i2.buyprice, 0) +
coalesce(i3.buyprice, 0) + coalesce(i4.buyprice, 0) + coalesce(i5.buyprice, 0) desc
limit 5;



-- #6
-- Throwing a game feels terrible. Consistently doing so feels even worse. List the Summoner names of the players, the number of games they lost inwhere team were the first to take down an inhibitor, and the rate of such games. 

with inhibitor_losing_games as (
select 
mp.accountid, pa.summonername,
count(*) as games_lost,
count(*) * 1.0 / (
select count(*) 
from matchparticipants mp_sub 
join loserdata ld_sub on mp_sub.gameid = ld_sub.gameid_loser and mp_sub.teamid = ld_sub.teamid
where mp_sub.accountid = mp.accountid) as loss_rate
from matchparticipants mp
inner join loserdata ld 
on mp.gameid = ld.gameid_loser and mp.teamid = ld.teamid inner join playeraccounts pa 
on mp.accountid = pa.accountid
where ld.firstinhibitor = 'TRUE' 
group by mp.accountid, pa.summonername)
select summonername, games_lost,
round(loss_rate * 100, 2) as loss_rate_percentage
from inhibitor_losing_games
order by games_lost desc, loss_rate_percentage desc;


-- #7
-- Ban rate is also a good indicator of champion power - the most banned champions tend to be the ones that are considered “overpowered”. List the champions by descending order of ban rate. 

select c.key as champion_id, c.name as champion_name,
round((count(*) * 100.0) / (select count(distinct gameid_winner) from winnerdata), 2) as ban_rate
from (
select firstban_winner as championid from winnerdata
union all
select secondban_winner from winnerdata
union all
select thirdban_winner from winnerdata
union all
select forthban_winner from winnerdata
union all
select fifthban_winner from winnerdata
union all
select firstban_loser from loserdata
union all
select secondban_loser from loserdata
union all
select thirdban_loser from loserdata
union all
select forthban_loser from loserdata
union all
select fifthban_loser from loserdata) as bans inner join champion c 
on bans.championid = c.key
group by c.key, c.name
order by round((count(*) * 100.0) / (select count(distinct gameid_winner) from winnerdata), 2) desc;


-- #8
-- A key part of meta analysis is understanding which lane has the most power, and which champions are prevalent in those lanes. List the win rate of each lane, and the top 5 most played champions in each lane. 

with lane_win_rates as (
select mp.lane as lane,
round(sum(case when mp.teamid = wd.teamid then 1 else 0 end) * 100.0 / count(mp.gameid), 2) as win_rate
from matchparticipants mp inner join winnerdata wd 
on mp.gameid = wd.gameid_winner
group by mp.lane),
lane_top_champions as (
select mp.lane as lane, c.name as champion_name, count(*) as games_played,
row_number() over (partition by mp.lane order by count(*) desc) as ranking
from matchparticipants mp inner join champion c 
on mp.championid = c.key
group by 
mp.lane, c.name)
select lw.lane, lw.win_rate, ltc.champion_name, ltc.games_played
from lane_win_rates lw left join lane_top_champions ltc 
on lw.lane = ltc.lane
where ltc.ranking <= 5
order by lw.lane, ltc.ranking;
