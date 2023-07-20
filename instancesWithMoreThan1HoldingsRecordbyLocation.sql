SELECT
	count(*),
	hrt.instance_id AS instance_uuid,
	it.hrid AS instance_hrid,
	lt.name AS location_name,
	hrt.call_number AS holdings_call_number,
	concat(it.hrid, '_', lt.name, '_', hrt.call_number_prefix, '_', hrt.call_number, '_', hrt.call_number_suffix) AS count_field
FROM 
	inventory.holdings_record__t hrt
	LEFT JOIN inventory.location__t lt ON lt.id = hrt.permanent_location_id 
	LEFT JOIN inventory.instance__t it ON it.id = hrt.instance_id 
GROUP BY 
	location_name,
	instance_hrid,
	instance_uuid,
	holdings_call_number,
	count_field
HAVING count(hrt.id) > 1;