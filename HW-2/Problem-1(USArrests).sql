use ids13db;

select * from USArrests;

Set SQL_SAFE_UPDATES = 0;

update USArrests
set Assault = null 
where Assault = 0;

select * from USArrests; 

select 
@avg_Assault := format(avg(Assault),2)
from USArrests;

Set SQL_SAFE_UPDATES = 0;
update USArrests
set Assault =  @avg_Assault
where Assault is null;

select * from USArrests;

Select max(Murder), min(Murder),
format(avg(Murder),2) as "Mean(Murder)",
format(variance(Murder),2) as "Variance(Murder)"
from USArrests;

Select max(Assault), min(Assault),
format(avg(Assault),2) as "Mean(Assault)",
format(variance(Assault),2) as "Variance(Assault)"
from USArrests;

Select max(UrbanPop), min(UrbanPop),
format(avg(UrbanPop),2) as "Mean(UrbanPop)",
format(variance(UrbanPop),2)
from USArrests;

Select State, Murder as "Max(Murder)"
from USArrests
where Murder = (select max(Murder)
                from USArrests);

select State, UrbanPop
from USArrests
order by UrbanPop asc;

SELECT STATE, found_rows() as no_of_rows
FROM (SELECT STATE
FROM USArrests where murder > (SELECT MURDER FROM USArrests WHERE STATE = 'Arizona')
GROUP BY STATE) as greater;

