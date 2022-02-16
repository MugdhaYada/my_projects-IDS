use ids13db;

select * from child_mortality;
  
Set SQL_SAFE_UPDATES = 0;
  
update child_mortality
set Under_five_mortality_rate = null
where Under_five_mortality_rate = 0;
  
update child_mortality
set Infant_mortality_rate = null
where Infant_mortality_rate = 0;
  
update child_mortality
set Neonatal_mortality_rate = null
where Neonatal_mortality_rate = 0;

select * from child_mortality;
  
Set SQL_SAFE_UPDATES = 0;

Set @row_index := -1;
  
Update child_mortality
set Under_five_mortality_rate = 
(SELECT avg(subq.Under_five_mortality_rate) as "median(UnderFiveMortalityRate)"
FROM (
SELECT @row_index:=@row_index + 1 AS row_index, Under_five_mortality_rate
    FROM child_mortality
	ORDER BY Under_five_mortality_rate)AS subq
	WHERE subq.row_index 
IN (FLOOR(@row_index / 2) , CEIL(@row_index / 2)))
where Under_five_mortality_rate is null;

Select Year, Neonatal_mortality_rate
from child_mortality
where Neonatal_mortality_rate > (Select avg(Neonatal_mortality_rate)
							     as averageOfNeonatal
                                 from child_mortality);
select * from child_mortality;
  
Set SQL_SAFE_UPDATES = 0;

Set @row_index := -1;
  
Update child_mortality
set Infant_mortality_rate = 
(SELECT avg(subq.Infant_mortality_rate) 
    FROM (
    SELECT @row_index:=@row_index + 1 AS row_index, Infant_mortality_rate
    FROM child_mortality
    ORDER BY Infant_mortality_rate
  ) AS subq
  WHERE subq.row_index 
  IN (FLOOR(@row_index / 2) , CEIL(@row_index / 2)))
  where Infant_mortality_rate is null;
  
select * from child_mortality;
  
Set SQL_SAFE_UPDATES = 0;

Set @row_index := -1;

Update child_mortality
  set Neonatal_mortality_rate = 
  (SELECT avg(subq.Neonatal_mortality_rate) as "median(NeonatalMortalityRate)"
    FROM (
    SELECT @row_index:=@row_index + 1 AS row_index, Neonatal_mortality_rate
    FROM child_mortality
    ORDER BY Neonatal_mortality_rate
  ) AS subq
  WHERE subq.row_index 
  IN (FLOOR(@row_index / 2) , CEIL(@row_index / 2)))
  where Neonatal_mortality_rate is null;
  
select * from child_mortality;


SELECT year,infant_mortality_rate, 
'MIN-INFANT MORTALITY RATE' as type 
from child_mortality
where infant_mortality_rate = (select min(infant_mortality_rate)  from child_mortality)
UNION
SELECT year,infant_mortality_rate, 
'MAX-INFANT MORTALITY RATE' as type 
from child_mortality
where infant_mortality_rate = (select MAX(infant_mortality_rate) from child_mortality);

select
@avg_Neonatal := format(avg(Neonatal_mortality_rate),2)
from child_mortality;

Select year 
from child_mortality
where Neonatal_mortality_rate > (select year 
                                 from child_mortality
                                 where Neonatal_mortality_rate > @avg_Neonatal);

select Infant_mortality_rate
from child_mortality
order by Infant_mortality_rate desc;

Select max(Under_five_mortality_rate), min(Under_five_mortality_rate),
format(avg(Under_five_mortality_rate),2) as "Mean(Neonatal_mortality_rate)",
format(variance(Under_five_mortality_rate),2) as "Variance(Under_five_mortality_rate)",
format(std(Under_five_mortality_rate),2) as "Standard Deviation"
from child_mortality;

Select max(Infant_mortality_rate), min(Infant_mortality_rate),
format(avg(Infant_mortality_rate),2) as "Mean(Neonatal_mortality_rate)",
format(variance(Infant_mortality_rate),2) as "Variance(Infant_mortality_rate)",
format(std(Infant_mortality_rate),2) as "Standard Deviation"
from child_mortality;

Select max(Neonatal_mortality_rate), min(Neonatal_mortality_rate),
format(avg(Neonatal_mortality_rate),2) as "Mean(Neonatal_mortality_rate)",
format(variance(Neonatal_mortality_rate),2) as "Variance(Neonatal_mortality_rate)",
format(std(Neonatal_mortality_rate),2) as "Standard Deviation"
from child_mortality;

Alter table child_mortality
add Above_five_mortality_rate float;

Set SQL_SAFE_UPDATES = 0;

update child_mortality 
set Above_five_mortality_rate = format(((under_five_mortality_rate - infant_mortality_rate) + (infant_mortality_rate - neonatal_mortality_rate)) / 4,2);


select * from child_mortality;


