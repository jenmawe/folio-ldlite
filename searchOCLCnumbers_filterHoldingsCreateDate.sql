--This query aggregates OCLC numbers from instances for holdings created after 2-1-2023.
--The location name prefix can be updated.
--The date can be updated.
SELECT 
	iti.id AS instance_uuid,
	iti.hrid AS instance_hrid,
	iti.title,
	string_agg(iti.identifiers__value, ' | ') AS identifiers,
	lt.name AS location_name
FROM 
	inventory.instance__t__identifiers iti 
	LEFT JOIN inventory.holdings_record__t hrt ON hrt.instance_id = iti.id
	LEFT JOIN inventory.location__t lt ON lt.id = hrt.permanent_location_id 
WHERE 
	iti.identifiers__identifier_type_id = '439bfbae-75bc-4f74-9fc7-b2a2d47ce3ef'
AND 
	lt.name LIKE 'UM%'
AND 
	hrt.metadata__created_date > '2023-02-01'
GROUP BY 
	iti.id,
	iti.hrid,
	iti.title,
	lt.name
	