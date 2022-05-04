select d.campaign_id,
		d.amount,
		c.title,
		cf.flag,
		case 
			when t.user_id is not null then 'yes'
			else 'no'
			end as is_complaint,
		count(t.id) as 'no_of_complain',
		round(coalesce((select count(t.priority) from ticket t where priority = 'high')/ count(t.priority),0),1) as 'percentage_of_high_priority_ticket'
		

from donation d

left join campaign c 
	on  d.campaign_id = c.id 
	
left join campaign_flag cf 
	on cf.campaign_id = d.campaign_id 
left join ticket t 
	on t.user_id = d.user_id 

where d.status = 4

group by d.user_id 
;




