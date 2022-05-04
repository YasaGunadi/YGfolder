

-- select date(from_unixtime(created)) as 'waktu', count(distinct user_id) jumlah_new_donatur from donation d
-- group by 1;

select date(from_unixtime(d.created)) as 'tanggal',
		c.title as 'campaign',
		count(d.id) as 'Donation Amount',
		sum(ast.spend) as 'Ads Spending',
		sum(d.amount) as 'Total Donation',
		sum(v.pageview) as 'Pageview',
		count(distinct d.user_id) 'Total New User',
		round(count(d.id)/v.pageview * 100,2) 'Conversion Rate Percentage',
		round(sum(ast.spend)/sum(d.amount),2) 'Spending per Donation Percentage'
		
from donation d

left join campaign c 
	on c.id = d.campaign_id
left join ads_spent ast 
	on ast.short_url = c.url
left join visit v 
	on v.campaign_url = c.url
where d.status=4
group by tanggal, 'campaign' 
order by 1 desc;