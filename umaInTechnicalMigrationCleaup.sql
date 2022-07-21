-- This query returns the holdings UUID and HRID, the instance UUID and HRID, instance title --
-- the instance identifiers only for the Previous Aleph System number, item barcode, and item --
-- material type for any barcodes that end with -UMA and that in the FOLIO Location of
-- Technical Migration. --
SELECT 
	hrt.id AS holdings_uuid,
	hrt.hrid AS holdings_hrid,
	hrt.instance_id AS instance_uuid,
	it2.hrid AS instance_hrid,
	it2.title AS instance_title,
	it.barcode,
	iti.identifiers__value AS identifier,
	mtt.name AS item_material_type_name
FROM 
	inventory.holdings_record__t AS hrt
	LEFT JOIN inventory.item__t AS it ON it.holdings_record_id = hrt.id
	LEFT JOIN inventory.instance__t AS it2 ON it2.id = hrt.instance_id 
	LEFT JOIN inventory.material_type__t AS mtt ON mtt.id = it.material_type_id 
	LEFT JOIN inventory.instance__t__identifiers AS iti ON iti.id = it2.id
WHERE
	hrt.permanent_location_id = '55cb0d2b-791e-46db-8470-e6f7ac23c327'
AND 
	iti.identifiers__identifier_type_id = '11effde5-6bf4-49ac-b9a4-040ef765ed88'
AND 
	it.barcode LIKE '%-UMA'