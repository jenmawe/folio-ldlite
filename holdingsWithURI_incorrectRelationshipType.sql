-- This query searches holdings records for UM with an electronic access uri and where the electronic access 
-- relationship type is not Resource.
SELECT 
	hrtea.id AS holdings_uuid,
	hrtea.hrid AS holdings_hrid,
	hrtea.call_number AS holdings_call_number,
	eart.name AS holdings_elec_access_type_name,
	lt.name AS holdings_location_name
FROM 
	inventory.holdings_record__t__electronic_access hrtea
	LEFT JOIN inventory.electronic_access_relationship__t eart ON eart.id = hrtea.electronic_access__relationship_id 
	LEFT JOIN inventory.location__t lt ON lt.id = hrtea.permanent_location_id
WHERE 
	hrtea.electronic_access__uri IS NOT NULL
AND 
	hrtea.effective_location_id in (
        select
        	distinct(location__t.id)
        from
        	inventory.location__t
        	inner join inventory."loc-campus__t" on "loc-campus__t".id = location__t.campus_id
        where
       		"loc-campus__t".code = 'UM')
AND 
	eart.name != 'Resource';