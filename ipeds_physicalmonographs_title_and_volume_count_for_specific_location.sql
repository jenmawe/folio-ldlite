--This query returns a count of titles, or srs bib record uuids, and items, or item uuids, and the instance uuid for all those physical monographs in one specific location.
--Created in the 5C Data Import lab session: Aaron Neslin, Jen Bolmarcich, Sara Colglazier, Tim Dannay, Jennifer Eustis on 20230106.
SELECT 
	COUNT(DISTINCT sm.srs_id) AS title_count, --Count of all srs bib uuids that have a bibliographic level or LDR position 7 for monographs
	COUNT(DISTINCT it.id) AS item_count, --Count of all item uuids that have a bibliographic level or LDR position 7 for monographs
	lt.name AS location_name, --Name of the location from the inventory.location_t table
	hrt.instance_id --INSTANCE uuid 
FROM 
	public.srs_marctab sm 
	LEFT JOIN public.srs_marctab sm2 on sm2.srs_id::uuid = sm.srs_id::uuid
	LEFT JOIN inventory.holdings_record__t hrt on sm.instance_id::uuid = hrt.instance_id::uuid 
	LEFT JOIN inventory.location__t lt on lt.id::uuid = hrt.permanent_location_id::uuid
	LEFT JOIN inventory.item__t it ON it.holdings_record_id::uuid = hrt.id::uuid
WHERE 
	sm.field = '000'
AND 
	substring(sm.CONTENT FROM 8 FOR 1) = 'm' --LDR POSITION 7 FOR monographs
AND 
	substring(sm.content from 7 for 1) = 'a' --LDR POSITION 6 FOR LANGUAGE material
AND 
	sm2.field = '008'
AND 
	substring(sm2.content from 24 for 1) not in ('o', 's')  --008 POSITION 23 FOR form OF item AND online OR the OLD s FOR electronic
AND 
	lt.code  = 'MPPER' --Enter a SPECIFIC LOCATION code
GROUP BY 
	lt.name,
	hrt.instance_id
ORDER BY 
	lt.name ;