--Query 1
select
to_char(date_trunc('month', booking.start_date_time), 'Month')
AS Month,
COUNT(*) AS Total,
count(case when lesson.max=1 then 1 else null end)
AS Individual,
count(case when lesson.max>1 and ensemble.genre_id is null then 1 else null end)
As group,
count(ensemble.genre_id)
As Ensemble
from ((lesson inner join booking on lesson.booking_id=booking.id)
left join ensemble on lesson.booking_id=ensemble.lesson_id)
where extract (year from booking.start_date_time)= extract ('year' from now())
group by date_trunc('month', booking.start_date_time)
order by date_trunc('month', booking.start_date_time);

--Query 2
select count - 1 as "No of Siblings", count(*) as "No of Students"
from(select count(p.id) from student s, person p 
where p.sibling_group_id = s.person_id
group by p.sibling_group_id)
group by count order by count asc

--Query 3
select  p.id as "instructor id",  name, count(l.booking_id) as "no of lessons"
from instructor i, lesson l, booking b, person p  
	where i.person_id = l.person_id and l.booking_id = b.id and p.id = i.person_id 
	and date_trunc('year', b.start_date_time) = date_trunc('year', now()) 
	and date_trunc('month', b.start_date_time) = date_trunc('month', now()) 
group by p.id,b.id having count(l.booking_id) > 0;

--Query 4
select
    case
        when extract(isodow from b.start_date_time) = 1 then 'Mon'
        when extract(isodow from b.start_date_time) = 2 then 'Tue'
        when extract(isodow from b.start_date_time) = 3 then 'Wed'
        when extract(isodow from b.start_date_time) = 4 then 'Thu'
        when extract(isodow from b.start_date_time) = 5 then 'Fri'
        when extract(isodow from b.start_date_time) = 6 then 'Sat'
        when extract(isodow from b.start_date_time) = 7 then 'Sun'
    end as day_of_week,
    g.genre,
    case
        when count >= max then 'No Seats'
        when max - count > 2 then 'Many Seats'
        else '1 or 2 Seats'
    end as seats_left
from (select l.max, l.booking_id, count(e2.lesson_id)
    from booking b
    join lesson l on l.booking_id = b.id
    join ensemble e on e.lesson_id = l.booking_id
    full join enrollment e2 on e2.lesson_id = l.booking_id
    where b.start_date_time > now() and b.end_date_time < now() + interval '7 days'
    group by l.booking_id)
join booking b on b.id = booking_id
join ensemble e on e.lesson_id = booking_id
join genre g on g.id = e.genre_id
order by b.start_date_time
