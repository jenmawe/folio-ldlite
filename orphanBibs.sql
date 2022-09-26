-- This query searches for orphan srs bibs across all schools
SELECT 
	rt.id AS srs_bib_uuid,
	rt.state AS srs_bib_state,
	rt.record_type AS srs_bib_record_type,
	rt.external_ids_holder__instance_id AS instance_uuid,
	rt.external_ids_holder__instance_hrid AS instance_hrid,
	rt.metadata__created_date,
	rt.metadata__updated_date,
	rt.metadata__created_by_user_id,
	rt.metadata__updated_by_user_id
FROM 
	source_record.records__t rt
WHERE
	rt.external_ids_holder__instance_id IS NULL ; 
