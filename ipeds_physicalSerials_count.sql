--This query returns a count of titles, or srs bib record uuids, for all those physical serials in a specific location.
--Created in the 5C Data Import lab session: Aaron Neslin, Jen Bolmarcich, Sara Colglazier, Tim Dannay, Jennifer Eustis on 20230106.
SELECT 
	COUNT(DISTINCT sm.srs_id) AS title_count, --Count of all srs bib uuids that have a bibliographic level or LDR position 7 for serials or integrating resource
	lt.name AS location_name --Name of the location from the inventory.location_t table
FROM 
	public.srs_marctab sm 
	LEFT JOIN public.srs_marctab sm2 ON sm2.srs_id::uuid = sm.srs_id::uuid
	LEFT JOIN inventory.holdings_record__t hrt ON sm.instance_id::uuid = hrt.instance_id::uuid 
	LEFT JOIN inventory.location__t lt ON lt.id::uuid = hrt.permanent_location_id::uuid
WHERE 
	sm.field = '000' --LDR field
AND 
	substring(sm.CONTENT FROM 8 FOR 1) in ('s', 'i') --LDR POSITION 7 FOR serials AND integrating resources
AND 
	substring(sm.content from 7 for 1) = 'a' --LDR POSITION 6 FOR LANGUAGE material
AND 
	sm2.field = '008'
AND 
	substring(sm2.content from 24 for 1) not in ('o', 's') --008 POSITION 23 FOR form OF item AND online OR the OLD s FOR electronic
AND 
	(lt.name like 'MH%' or  lt.code in ('FCANI', 'FCDPS', 'FCDPM')) --Looks FOR names that BEGIN WITH MH WHERE PERCENT sign IS the wildcard AND SPECIFIC codes
GROUP BY 
	ROLLUP(lt.name) --This will provide a total count AT the bottom
ORDER BY 
	lt.name ;

