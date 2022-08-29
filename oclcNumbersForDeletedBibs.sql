-- This query returns the instance uuid, title, hrid, boolean values for staff and discovery suppress, value for OCLC numbers and the date.
-- It filters on only those identifier values that begin with OC, that have the statistical code of Remove deleted resource, instance_type_id 
-- that have been updated after the date. 
SELECT 
	itsci.id,
	itsci.title,
	itsci.hrid,
	it.staff_suppress,
	it.discovery_suppress,
	iti.identifiers__value,
	it.metadata__updated_date::date
FROM 
	inventory.instance__t__statistical_code_ids itsci
	LEFT JOIN inventory.instance__t it ON it.id = itsci.id 
	LEFT JOIN inventory.instance__t__identifiers iti ON iti.id = it.id
WHERE 
	itsci.statistical_code_ids = '4921058f-8b68-43a7-a7d6-45f58c38aab9'
AND 
	iti.identifiers__value LIKE '(OC%'
AND 
	it.metadata__updated_date::date > '2022-08-22';