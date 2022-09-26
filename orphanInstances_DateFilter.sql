--This query finds orphan Instances or where there is an instance id and no holdings id.
--This query also picks up those instances marked for deletion that don't have all the fields filled out.
--Unlike the broader orphan instances, this filters for only those created after our migration date.
SELECT  
    it.id AS instance_uuid,
    it.hrid AS instance_hrid,
    hrt.id AS holdings_uuid,
    it.staff_suppress,
    it.discovery_suppress,
    sct.name AS instance_stat_code_name,
    it.metadata__created_date::date
FROM  
    inventory.instance__t it 
    left JOIN inventory.holdings_record__t hrt ON hrt.instance_id = it.id 
    LEFT JOIN inventory.instance__t__statistical_code_ids itsci ON itsci.id = it.id
    LEFT JOIN inventory.statistical_code__t sct ON sct.id = itsci.statistical_code_ids 
WHERE
    hrt.id IS NULL 
and it.metadata__created_date > '2022-07-01'