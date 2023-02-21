--This query finds orphan Instances or where there is an instance id and no holdings id.
--This query also picks up those instances marked for deletion that don't have all the fields filled out.
--Unlike the broader orphan instances, this filters for only those created after our migration date. Last ran 01-06-2023
SELECT  
    it.id AS instance_uuid,
    it.hrid AS instance_hrid,
    hrt.id AS holdings_uuid,
    hrt.hrid AS holdings_hrid,
    it.title,
    sct.name AS statistical_code_name,
    it.staff_suppress,
    it.discovery_suppress,
    it.metadata__created_date::date,
    ut.username,
    ut.personal__last_name,
    ut.personal__first_name
FROM  
    inventory.instance__t it 
    left JOIN inventory.holdings_record__t hrt ON hrt.instance_id::uuid = it.id::uuid
    LEFT JOIN inventory.instance__t__statistical_code_ids itsci ON itsci.id = it.id
    LEFT JOIN inventory.statistical_code__t sct ON sct.id = itsci.statistical_code_ids 
    LEFT JOIN users.users__t ut ON ut.id = it.metadata__updated_by_user_id 
WHERE
    hrt.id IS NULL
AND
	it.metadata__created_date > '2022-07-01'
AND 
	it.metadata__created_date < '2023-02-17'
ORDER BY 
	ut.username ;