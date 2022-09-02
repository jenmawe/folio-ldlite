-- Find instances with multiple contributors in UM locations
WITH contributors AS (
    SELECT
        itc.id,
        string_agg(itc.contributors__name, ' | ') AS contributors_names
    FROM
        inventory.instance__t__contributors AS itc
    GROUP BY
        itc.id
),
multivalues AS (
	SELECT
		cntr.id,
		cntr.contributors_names
	FROM 
		contributors AS cntr
	WHERE 
		cntr.contributors_names LIKE '%|%'
)
SELECT
	mv.id,
	it.hrid,
	mv.contributors_names,
	hrt.permanent_location_id,
	lt.name
FROM 
	multivalues AS mv
	LEFT JOIN inventory.holdings_record__t AS hrt ON hrt.instance_id::uuid = mv.id::uuid
	LEFT JOIN inventory.location__t AS lt ON lt.id::uuid = hrt.permanent_location_id::uuid
	LEFT JOIN inventory.instance__t AS it ON it.id::uuid = mv.id::uuid
WHERE 
	lt.name LIKE 'UM %'
AND
	hrt.permanent_location_id NOT IN ('5a8935d9-c657-4881-a28b-a05562c7b800', '5004bbd4-3885-4c4b-95a2-5410ea8a6d93')
	;